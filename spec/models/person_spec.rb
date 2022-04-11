require 'rails_helper'

RSpec.describe Person, type: :model do
  subject { build(:person) }

  it { is_expected.to have_many(:emitted_invoices) }
  it { is_expected.to have_many(:received_invoices) }

  context 'when validations' do
    it 'is presence' do
      expect(subject).to validate_presence_of(:rfc)
      expect(subject).to validate_presence_of(:name)
    end
    it 'is unique' do
      expect(subject).to validate_uniqueness_of(:rfc)
    end
  end
end
