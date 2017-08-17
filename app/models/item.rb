class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates_presence_of :name, :description, :unit_price
  validates_numericality_of :unit_price

  default_scope { order(id: :asc) }

  def self.most_items(input)
    input = input.to_i
    sql = "SELECT \"items\".* FROM \"items\" INNER JOIN \"invoice_items\" ON \"invoice_items\".\"item_id\" = \"items\".\"id\" INNER JOIN \"invoices\" ON \"invoices\".\"id\" = \"invoice_items\".\"invoice_id\" INNER JOIN \"transactions\" ON \"transactions\".\"invoice_id\" = \"invoices\".\"id\" INNER JOIN \"invoice_items\" \"invoice_items_invoices\" ON \"invoice_items_invoices\".\"invoice_id\" = \"invoices\".\"id\" WHERE \"transactions\".\"result\" = 0 GROUP BY items.id ORDER BY count(invoice_items.item_id * invoice_items.quantity) DESC LIMIT #{input}"
    ActiveRecord::Base.connection.execute(sql).to_json
  end

  def best_day
    # returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.
    invoices
    .select("invoices.*, invoices.created_at")
    .joins(:invoice_items)
    .group(:id)
    .order("sum(invoice_items.quantity) DESC")
    .first
    .created_at
  end
end
