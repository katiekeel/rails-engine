describe "Transaction relationship endpoints" do
  scenario "finds a list of associated invoices" do
    invoice = create(:invoice, :with_transactions)

    get "/api/v1/transactions/#{Transaction.first.id}/invoice"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to be invoice.id
  end
end
