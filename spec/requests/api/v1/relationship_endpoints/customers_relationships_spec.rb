describe "Customer relationship endpoints" do
  scenario "finds a list of associated transactions" do
    
  end
end

it "finds associated transactions" do
 invoice = create(:invoice)
 transactions = create_list(:transaction, 3, invoice_id: invoice.id)

 get "/api/v1/invoices/#{invoice.id}/transactions"
 json = JSON.parse(response.body)

 expect(response).to be_success
 expect(json.count).to eq 3
end
