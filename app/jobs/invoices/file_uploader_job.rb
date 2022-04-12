module Invoices
  class FileUploaderJob < ApplicationJob
    queue_as :default

    def perform(*args)
      @processor = InvoiceProcessor.find(args[0])
      @processor.run!

      upload_file
    rescue StandardError => e
      @processor.to_retry!
      raise(e)
    end

    private

    def upload_file
      uploader_klass.upload(invoice_processor: @processor)
    end

    def uploader_klass
      @uploader_klass ||= "Invoices::Operations::#{@processor.file_type.underscore.camelize}Uploader".constantize
    rescue StandardError => _e
      nil
    end
  end
end
