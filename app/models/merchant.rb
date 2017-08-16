class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  validates_presence_of :name

  def self.revenue(id)
    # returns the total revenue for that merchant across successful transactions
    Merchant.find(id).transactions.successful.joins(:invoice_items)
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.revenue_by_date(id, date = Time.parse(date).getutc)
    Merchant.find(id).invoices.where(created_at: date).joins(:transactions)
    .where(transactions: {result: "success"}).joins(:invoice_items)
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.favorite_customer(id)
    # returns the customer who has conducted the most total number of successful transactions.
    Merchant.find(id).transactions.successful
    .group(:customer_id).order('count_id desc').count('id').keys[0]
  end
end
