class ChangeInvoiceItemUnitPriceToString < ActiveRecord::Migration[5.1]
  def change
    change_column :invoice_items, :unit_price, :string
  end
end
