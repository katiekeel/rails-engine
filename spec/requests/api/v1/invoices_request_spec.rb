require 'spec_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices.json'

    expect(response).to be_success

    invoices = JSON.parse(response.body)

    expect(invoices.count).to eq(3)
  end

  it "can get one invoice by id" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["id"]).to eq id
  end

  it "finds one invoice by id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq invoice.id
  end

  it "finds one invoice by status" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?status=#{invoice.status}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["status"]).to eq invoice.status
  end

  it "finds one invoice by created at" do
    invoice = create(:invoice, created_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/invoices/find?created_at=2012-03-27T14:54:05.000Z"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq invoice.id
  end

  it "finds one invoice by updated at" do
    invoice = create(:invoice, updated_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/invoices/find?updated_at=2012-03-27T14:54:05.000Z"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq invoice.id
  end

  context "Case insensitive" do
    it "finds one invoice by status" do
      invoice = create(:invoice)

      get "/api/v1/invoices/find?status=#{invoice.status.downcase}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["status"]).to eq invoice.status

      get "/api/v1/invoices/find?status=#{invoice.status.upcase}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["status"]).to eq invoice.status
    end
  end

  it "finds one invoice by customer id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["customer_id"]).to eq invoice.customer_id
  end

  it "finds one invoice by merchant id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["merchant_id"]).to eq invoice.merchant_id
  end

  it "finds all invoices by status" do
    invoice_1 = create(:invoice, status: "invoice")
    invoice_2 = create(:invoice, status: "invoice")
    invoice_3 = create(:invoice, status: "invoice")

    get "/api/v1/invoices/find_all?status=invoice"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 3
    expect(json.first["status"]).to eq invoice_1.status
    expect(json[1]["status"]).to eq invoice_2.status
    expect(json[2]["status"]).to eq invoice_3.status
  end

  context "Case Insensitive" do
    it "finds all invoices by status" do
      invoice_1 = create(:invoice, status: "invoice")
      invoice_2 = create(:invoice, status: "invoice")
      invoice_3 = create(:invoice, status: "invoice")

      get "/api/v1/invoices/find_all?status=invoice"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq 3
      expect(json.first["status"]).to eq invoice_1.status
      expect(json[1]["status"]).to eq invoice_2.status
      expect(json[2]["status"]).to eq invoice_3.status
    end
  end

  it "finds all invoices by merchant id" do
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant: merchant)

    get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 3
    expect(json[0]["merchant_id"]).to eq merchant.id
    expect(json[1]["merchant_id"]).to eq merchant.id
    expect(json[2]["merchant_id"]).to eq merchant.id
  end

  it "finds all invoices by customer id" do
    customer = create(:customer)
    invoices = create_list(:invoice, 3, customer: customer)

    get "/api/v1/invoices/find_all?customer_id=#{customer.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 3
    expect(json[0]["customer_id"]).to eq customer.id
    expect(json[1]["customer_id"]).to eq customer.id
    expect(json[2]["customer_id"]).to eq customer.id
  end

  it "finds all invoices by created at" do
    invoices = create_list(:invoice, 3, created_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/invoices/find_all?created_at=2012-03-27T14:54:05.000Z"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to eq invoices.first.id
    expect(json[1]["id"]).to eq invoices[1].id
    expect(json[2]["id"]).to eq invoices[2].id
  end

  it "finds all invoices by updated at" do
    invoices = create_list(:invoice, 3, updated_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/invoices/find_all?updated_at=2012-03-27T14:54:05.000Z"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to eq invoices.first.id
    expect(json[1]["id"]).to eq invoices[1].id
    expect(json[2]["id"]).to eq invoices[2].id
  end

  it "finds a random invoice" do
    invoices = create_list(:invoice, 3)

    get "/api/v1/invoices/random.json"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json).to be_a(Hash)
    expect(Invoice.find(json["id"])).to be_a(Invoice)
  end

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
end
