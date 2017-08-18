require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context "Validations" do
    describe "Attributes" do
      it {should validate_presence_of(:name)}
    end

    describe "Relationships" do
      it {should have_many(:items)}
      it {should have_many(:invoices)}
      it {should have_many(:customers)}
      it {should have_many(:invoice_items)}
      it {should have_many(:transactions)}
    end
  end

  context "Methods" do
    it "revenue" do
      merchant = create(:merchant)

      invoice = create(:invoice, :with_invoice_items, :with_transactions, merchant: merchant)

      expect(Merchant.revenue(merchant.id)).to eq 6
    end

    it "revenue by date" do
      merchant = create(:merchant)

      invoice = create(:invoice, :with_invoice_items, :with_transactions, merchant: merchant)
      second_invoice = create(:invoice, :with_transactions, merchant: merchant)
      second_invoice.invoice_items << create_list(:invoice_item, 10)

      expect(Merchant.revenue_by_date(merchant.id, invoice.created_at)).to eq 6
      expect(Merchant.revenue_by_date(merchant.id, second_invoice.created_at)).to eq 20
    end

    it "favorite customer" do
      merchant = create(:merchant, :with_invoices)

      merchant.invoices.each do |invoice|
        invoice.transactions << create_list(:transaction, 2, result: 0)
      end

      expect(Merchant.favorite_customer(merchant.id)).to eq Customer.first.id
    end
  end
end
