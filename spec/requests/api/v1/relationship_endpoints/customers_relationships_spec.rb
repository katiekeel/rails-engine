describe "Customer relationship endpoints" do
  scenario "finds a list of associated transactions" do
    customer = create(:customer)
    transactions = create_list(:transaction, 2, customer: customer)

    get "/api/v1/customers/#{customer.id}/transactions"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to be transactions.first.id
  end

  scenario "finds a list of associated invoices" do
    customer = create(:customer, :with_invoices)

    get "/api/v1/customers/#{customer.id}/invoices"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to be Invoice.first.id
  end
end
