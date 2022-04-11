FactoryBot.define do
  factory :person do
    uuid { SecureRandom.uuid }
    name { "José Pérez #{SecureRandom.hex(4)}" }
  end
end
