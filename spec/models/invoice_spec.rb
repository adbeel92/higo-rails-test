require 'rails_helper'

RSpec.describe Invoice, type: :model do
  subject { build(:invoice) }

  it { is_expected.to belong_to(:emitter) }
  it { is_expected.to belong_to(:receiver) }

  context 'when validations' do
    it 'is presence' do
      expect(subject).to validate_presence_of(:uuid)
      expect(subject).to validate_presence_of(:amount)
    end
    it 'is unique' do
      expect(subject).to validate_uniqueness_of(:uuid).case_insensitive
    end
  end
end
