module Invoices
  module Operations
    class FilesUploader
      attr_reader :error_message

      class << self
        def run(user:, files:, file_type:)
          new(user: user, files: files, file_type: file_type).run
        end
      end

      def initialize(user:, files:, file_type:)
        @user = user
        @files = files
        @file_type = file_type.to_s
      end

      def run
        @files.each do |file|
          invoice_processor = InvoiceProcessor.create(
            user: @user, file: file, file_type: @file_type, status: :pending
          )
          Invoices::FileUploaderJob.perform_later(invoice_processor.id)
        end
      end
    end
  end
end
