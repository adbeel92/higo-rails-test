FactoryBot.define do
  factory :person do
    rfc { SecureRandom.hex(8) }
    name { "José Pérez #{SecureRandom.hex(4)}" }
  end
end
