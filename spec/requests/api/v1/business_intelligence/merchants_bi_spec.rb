require 'spec_helper'

describe "Merchants BI" do
  it "returns x number of merchants in order of revenue" do
    m1, m2, m3, m4, m5 = create_list(:merchant, 5)

   get '/api/v1/merchants/most_revenue?quantity=3'

   json = JSON.parse(response.body)

   expect(response).to be_success
  end
end

describe "Merchants BI API" do
  scenario "returns the revenue for a single merchant" do
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, :with_invoice_items, :with_transactions)
    merchant.invoices << invoices

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json["revenue"]).to eq "18.0"
  end

  scenario "returns the revenue for single merchant on a specific date" do
    date = "2012-03-16 11:55:05"
    merchant = create(:merchant)
    invoice = create(:invoice, :with_invoice_items, :with_transactions)
    invoice.update(created_at: date)
    merchant.invoices << invoice

    get "/api/v1/merchants/#{merchant.id}/revenue?date=#{date}"

    json = JSON.parse(response.body)
    expect(json["revenue"]).to eq "6.0"
  end

  scenario "returns favorite customer" do
    merchant = create(:merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    invoices = create_list(:invoice, 2, customer: customer_1, merchant: merchant)
    invoice = create(:invoice, customer: customer_2, merchant: merchant)
    transaction_1 = create(:transaction, invoice: invoices.first, result: 0)
    transaction_2 = create(:transaction, invoice: invoices[1], result: 0)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    json = JSON.parse(response.body)
    expect(json["id"]).to eq customer_1.id
  end
end
