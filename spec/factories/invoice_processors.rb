FactoryBot.define do
  factory :invoice_processor do
    invoice
    user
    status { :pending }
    file { nil }
    file_type { :xml }
  end
end
