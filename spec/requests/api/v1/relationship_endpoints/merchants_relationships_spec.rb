describe "Merchant relationship endpoints" do
  scenario "finds a list of associated invoices" do
    invoice = create(:invoice)

    get "/api/v1/merchants/#{invoice.merchant.id}/invoices"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to be invoice.id
  end

  scenario "finds a list of associated items" do
    merchant = create(:merchant, :with_items)

    get "/api/v1/merchants/#{merchant.id}/items"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to be merchant.items.first.id
  end
end
