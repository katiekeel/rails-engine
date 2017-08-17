require 'rails_helper'

RSpec.describe Item, type: :model do
  context "Validations" do
    describe "Attributes" do
      it {should validate_presence_of(:name)}
      it {should validate_presence_of(:description)}
      it {should validate_presence_of(:unit_price)}
      it {should validate_numericality_of(:unit_price)}
    end

    describe "Relationships" do
      it {should belong_to(:merchant)}
      it {should have_many(:invoice_items)}
      it {should have_many(:invoices)}
    end
  end


  context "Methods" do
    scenario "most items" do
      most_sold_item = create(:item)
      other_item = create(:item)

      most_sold_invoice_items = create_list(:invoice_item, 3, item: most_sold_item)
      other_invoice_items = create_list(:invoice_item, 3, item: other_item)

      most_sold_invoice = create(:invoice)
      most_sold_invoice.invoice_items << most_sold_invoice_items

      other_invoice = create(:invoice)
      other_invoice.invoice_items << other_invoice_items

      most_sold_transactions = create_list(:transaction, 3, result: 0, invoice: most_sold_invoice)
      other_transactions = create_list(:transaction, 2, result: 0, invoice: other_invoice)

      expect(Item.most_items(1)).to include most_sold_item.id.to_s
      expect(Item.most_items(2)).to include other_item.id.to_s
    end

    scenario "best day" do
      item = create(:item)
      less_invoice_items = create_list(:invoice_item, 3, item: item)
      more_invoice_items = create_list(:invoice_item, 5, item: item)

      first_day_invoice = create(:invoice)
      first_day_invoice.invoice_items << less_invoice_items

      second_day_invoice = create(:invoice)
      second_day_invoice.invoice_items << more_invoice_items

      expect(item.best_day).to eq second_day_invoice.created_at
    end
  end
end
