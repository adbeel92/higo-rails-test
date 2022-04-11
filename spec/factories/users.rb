FactoryBot.define do
  factory :user do
    email { "test+#{SecureRandom.hex(4)}@email.com" }
    password { 'abc123' }
  end
end
