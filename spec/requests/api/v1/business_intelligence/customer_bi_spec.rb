describe "Customers BI API" do
  scenario "returns favorite merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer = create(:customer)
    invoices = create_list(:invoice, 2, customer: customer, merchant: merchant_1)
    invoice = create(:invoice, customer: customer, merchant: merchant_2)
    transaction_1 = create(:transaction, invoice: invoices.first, result: 0)
    transaction_2 = create(:transaction, invoice: invoices[1], result: 0)

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    json = JSON.parse(response.body)
    expect(json["id"]).to eq merchant_1.id
  end
end
