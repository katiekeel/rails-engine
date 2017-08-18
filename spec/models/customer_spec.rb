require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Validations" do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end

  describe "Relationships" do
    it {should have_many(:invoices)}
    it {should have_many(:transactions)}
    it {should have_many(:merchants)}
  end

  describe "Methods" do
    scenario "favorite merchant" do
      favorite_merchant = create(:merchant)
      other_merchant = create(:merchant)

      customer = create(:customer)

      favorite_merchant_invoice = create_list(:invoice, 3, :with_transactions, merchant: favorite_merchant, customer: customer)
      other_merchant_invoice = create_list(:invoice, 2, :with_transactions, merchant: other_merchant, customer: customer)

      expect(customer.favorite_merchant).to eq favorite_merchant
    end
  end
end
