class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices
  validates_presence_of :first_name, :last_name

  def favorite_merchant
    merchants
    .select("merchants.*, count(transactions.id) AS transaction_count").joins(:transactions)
    .where("transactions.result = ?", 0)
    .group(:id)
    .order("transaction_count DESC")
    .first
  end
end
