class Transaction < ApplicationRecord
  belongs_to :invoice
  has_many :invoice_items, through: :invoice
  has_one :customer, through: :invoice

  enum result: ["success", "failed"]

  validates_presence_of :credit_card_number, :result
  validates_numericality_of :credit_card_number

  scope :successful, -> { where(result: "success") }
end
