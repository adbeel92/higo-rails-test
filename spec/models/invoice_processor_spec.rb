require 'rails_helper'

RSpec.describe InvoiceProcessor, type: :model do
  subject { build(:invoice_processor) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:invoice).optional }
  it { is_expected.to have_one(:file_attachment) }

  context 'when validations' do
    it 'is presence' do
      expect(subject).to validate_presence_of(:status)
      expect(subject).to validate_presence_of(:file_type)
    end
  end
end
