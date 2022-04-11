FactoryBot.define do
  factory :invoice do
    uuid { SecureRandom.uuid }
    association :emitter, factory: :person
    association :receiver, factory: :person
    amount { '9.99' }
    currency { 'CAD' }
    emitted_at { '2022-04-10 21:46:10' }
    expires_at { '2022-04-10 21:46:10' }
  end
end
