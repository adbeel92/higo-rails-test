require 'rails_helper'

RSpec.describe 'Invoices', type: :request do
  describe 'GET /invoices' do
    context 'without authentication' do
      it 'returns http found' do
        get '/invoices'
        expect(response).to have_http_status(:found)
      end
    end

    context 'with user authenticated' do
      include_context 'with user authenticated'

      it 'returns http success' do
        get '/invoices'
        expect(response).to have_http_status(:success)
      end
    end
  end
end
