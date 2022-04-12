require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { is_expected.to have_many(:invoices) }
  it { is_expected.to have_many(:invoice_processors) }

  context 'when validations' do
    it 'is presence' do
      expect(subject).to validate_presence_of(:email)
    end
    it 'is unique' do
      expect(subject).to validate_uniqueness_of(:email).case_insensitive
    end
  end
end
