require 'rails_helper'

RSpec.describe Invoices::FileUploaderJob, type: :job do
  let(:invoice_processor1) { create(:invoice_processor, file: fixture_file_upload('processor_success.xml')) }
  let(:invoice_processor2) { create(:invoice_processor, file: fixture_file_upload('processor_error.xml')) }
  let(:args1) { [invoice_processor1.id] }
  let(:args2) { [invoice_processor2.id] }

  describe '#perform_later' do
    it 'enqueues file uploader' do
      ActiveJob::Base.queue_adapter = :test
      expect { described_class.perform_later(*args1) }.to have_enqueued_job(described_class)
        .with(*args1)
        .on_queue('default')
    end
  end

  describe '#perform_now' do
    context 'when success' do
      it 'performs file uploader' do
        described_class.perform_now(*args1)
        expect(invoice_processor1.reload.status).to eq('uploaded')
      end
    end

    context 'when fails' do
      it 'raise error' do
        described_class.perform_now(*args2)
        expect(invoice_processor2.reload.error?).to be(true)
      end
    end
  end
end
