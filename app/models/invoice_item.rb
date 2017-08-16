class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates_presence_of :quantity, :unit_price
  validates_numericality_of :quantity, :unit_price

  def self.most_items(input)
    invoice_items = InvoiceItem.group(:item_id).order('sum_quantity desc').sum('quantity')
    items = Item.find(invoice_items.keys[0..input.to_i]) if input.to_i > 1
    items = Item.find(invoice_items.keys[0]) if input.to_i == 1
  end
end
