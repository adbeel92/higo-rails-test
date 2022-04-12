module Invoices
  module Operations
    class XmlUploader
      attr_reader :error_message

      class << self
        def upload(invoice_processor:)
          new(invoice_processor: invoice_processor).upload
        end
      end

      def initialize(invoice_processor:)
        @invoice_processor = invoice_processor
      end

      def upload
        read_file
        store_invoice
        @invoice_processor.complete!
      rescue StandardError => e
        @invoice_processor.assign_attributes(error_message: e.message)
        @invoice_processor.to_retry!
      end

      private

      def read_file
        @invoice_processor.data = {
          uuid: invoice_hash['invoice_uuid'].gsub(/^(\w{8})(\w{4})(\w{4})(\w{4})/, '\1-\2-\3-\4-')[0..35],
          emitter_id: find_or_initialize_person(
            filter: { rfc: invoice_hash.dig('emitter', 'rfc') },
            data: invoice_hash['emitter'].slice('name')
          ),
          receiver_id: find_or_initialize_person(
            filter: { rfc: invoice_hash.dig('receiver', 'rfc') },
            data: invoice_hash['receiver'].slice('name')
          ),
          amount: invoice_hash['amount_cents'],
          currency: invoice_hash['amount_currency'],
          emitted_at: invoice_hash['emitted_at'],
          expires_at: invoice_hash['expires_at']
        }
      end

      def store_invoice
        invoice = @invoice_processor.build_invoice(@invoice_processor.data.merge(user_id: @invoice_processor.user_id))
        return true if invoice.save

        @invoice_processor.update(error_message: invoice.errors.full_messages.join('. '))
        false
      end

      def invoice_hash
        @invoice_hash ||= Hash.from_xml(@invoice_processor.file.download)['hash'] || raise
      rescue StandardError => _e
        raise(Errors::InvalidXml)
      end

      def find_or_initialize_person(filter: {}, data: {})
        instance = Person.find_or_initialize_by(filter)
        instance.assign_attributes(data)
        instance.save
        instance.id
      end
    end
  end
end
