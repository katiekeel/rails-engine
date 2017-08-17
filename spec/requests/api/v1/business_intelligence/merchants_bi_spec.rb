require 'spec_helper'

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
end
