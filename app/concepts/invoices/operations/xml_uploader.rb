module Invoices
  module Operations
    class XmlUploader
      attr_reader :error_message

      def initialize(user:, xml_file:)
        @user = user
        @xml_content = xml_file.read.to_s
      end

      def run
        return false unless read_file

        store_invoice
      rescue StandardError => e
        @error_message = e.message
        false
      end

      private

      def read_file
        @invoice_data = {
          uuid: invoice_hash['invoice_uuid'].gsub(/^(\w{8})(\w{4})(\w{4})(\w{4})/, '\1-\2-\3-\4-')[0..35],
          emitter: find_or_initialize_person(
            filter: { rfc: invoice_hash.dig('emitter', 'rfc') },
            data: invoice_hash['emitter'].slice('name')
          ),
          receiver: find_or_initialize_person(
            filter: { rfc: invoice_hash.dig('receiver', 'rfc') },
            data: invoice_hash['receiver'].slice('name')
          ),
          amount: invoice_hash['amount_cents'],
          currency: invoice_hash['amount_currency'],
          emitted_at: invoice_hash['emitted_at'],
          expires_at: invoice_hash['expires_at']
        }
      rescue StandardError => e
        @error_message = e.message
        false
      end

      def store_invoice
        invoice = @user.invoices.build(@invoice_data)
        return true if invoice.save

        @error_message = invoice.errors.full_messages.join('. ')
        false
      end

      def invoice_hash
        @invoice_hash ||= Hash.from_xml(@xml_content)['hash'] || raise
      rescue StandardError => _e
        raise(Errors::InvalidXml)
      end

      def find_or_initialize_person(filter: {}, data: {})
        instance = Person.find_or_initialize_by(filter)
        instance.assign_attributes(data)
        instance
      end
    end
  end
end
