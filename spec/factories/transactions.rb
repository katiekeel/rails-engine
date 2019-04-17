FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number 1234567812345678
    result 1
  end
end
