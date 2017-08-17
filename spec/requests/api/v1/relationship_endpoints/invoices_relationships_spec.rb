describe "Invoices relationships API" do
  it "finds associated transactions" do
   invoice = create(:invoice)
   transactions = create_list(:transaction, 3, invoice_id: invoice.id)

   get "/api/v1/invoices/#{invoice.id}/transactions"
   json = JSON.parse(response.body)

   expect(response).to be_success
   expect(json.count).to eq 3
  end


  it "finds associated invoice_items" do
    invoice = create(:invoice)
    invoice_items = create_list(:invoice_item, 3, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"
    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 3
  end

  it "finds associated items" do
    invoice = create(:invoice)
    invoice_items = create_list(:invoice_item, 3, invoice_id: invoice.id)

    get "/api/v1/invoices/#{invoice.id}/items"
    json = JSON.parse(response.body)

    expect(response).to be_success
   expect(json.count).to eq 3
  end

  it "finds associated customer" do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}/customer"
    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.class).to eq Hash
    expect(json["id"]).to eq invoice.customer.id
  end

  it "finds associated merchant" do
    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}/merchant"
    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.class).to eq Hash
    expect(json["id"]).to eq invoice.merchant.id
  end
end
