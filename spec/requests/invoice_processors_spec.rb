require 'rails_helper'

RSpec.describe 'InvoiceProcessors', type: :request do
  describe 'GET /invoice_processors' do
    context 'without authentication' do
      it 'returns http found' do
        get '/invoice_processors'
        expect(response).to have_http_status(:found)
      end
    end

    context 'with user authenticated' do
      include_context 'with user authenticated'

      it 'returns http success' do
        get '/invoice_processors'
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST /invoice_processors/upload' do
    context 'without authentication' do
      it 'returns http found' do
        post '/invoice_processors/upload'
        expect(response).to have_http_status(:found)
      end
    end

    context 'with user authenticated' do
      include_context 'with user authenticated'

      let(:payload) do
        {
          invoice_processor: {
            file_type: 'xml',
            files: [
              fixture_file_upload('processor_success.xml')
            ]
          }
        }
      end

      it 'returns http success' do
        post '/invoice_processors/upload', params: payload

        expect(response).to redirect_to(:invoice_processors)
      end
    end
  end
end
