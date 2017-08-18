class ChangeItemUnitPriceToString < ActiveRecord::Migration[5.1]
  def change
    change_column :items, :unit_price, :string
  end
end
