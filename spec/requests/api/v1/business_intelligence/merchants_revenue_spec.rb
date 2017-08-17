require 'spec_helper'

describe "Revenue for a single merchant API" do
  scenario "returns the revenue" do
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, :with_invoice_items, :with_transactions)
    merchant.invoices << invoices

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_success

    json = JSON.parse(response.body)
    expect(json["revenue"]).to eq "18.0"
  end
end
