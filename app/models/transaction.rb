class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: ["success", "failed"]

  validates_presence_of :credit_card_number, :result
  validates_numericality_of :credit_card_number
end
