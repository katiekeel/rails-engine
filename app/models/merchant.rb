class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  validates_presence_of :name

  def self.revenue(id)
    Merchant.find(id)
    .transactions
    .successful
    .joins(:invoice_items)
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.revenue_by_date(id, date = Time.parse(date).getutc)
    Merchant.find(id)
    .invoices
    .where(created_at: date)
    .joins(:transactions)
    .where(transactions: {result: "success"})
    .joins(:invoice_items)
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.favorite_customer(id)
    Merchant.find(id)
    .transactions
    .successful
    .group(:customer_id)
    .order('count_id desc')
    .count('id')
    .keys[0]
  end

  def self.most_revenue(quantity)
    joins(:invoice_items).select('merchants.id, merchants.name, sum(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .group('merchants.id')
      .order('revenue DESC')
      .limit(quantity)
  end

  def self.revenue_date(date)
   joins(:invoice_items)
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .where(invoices: {created_at: date})
    .group ('merchants.id')
  end
end
