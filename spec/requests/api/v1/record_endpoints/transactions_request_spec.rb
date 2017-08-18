require 'spec_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_success

    json = JSON.parse(response.body)

    expect(json.count).to eq(3)
  end

  it "can get one transaction by its id" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(id)
  end

  it "finds one transaction by invoice_id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(transaction.id)
  end

  it "finds one transaction by credit card number" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(transaction.id)
  end

  it "finds one transaction by merchant_id " do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?merchant_id=#{transaction.merchant.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(transaction.id)
  end

  it "finds one transaction by result" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?result=#{transaction.result}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["result"]).to eq transaction.result
  end

  it "finds all transactions by invoice id" do
    invoice = create(:invoice)
    transactions = create_list(:transaction, 3, invoice: invoice)

    get "/api/v1/transactions/find_all?invoice_id=#{invoice.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to eq transactions.first.id
    expect(json[1]["id"]).to eq transactions[1].id
    expect(json[2]["id"]).to eq transactions[2].id
  end

  it "finds all transactions by credit card number" do
    credit_card_number = 4654405418249632
    transactions = create_list(:transaction, 3, credit_card_number: 4654405418249632)

    get "/api/v1/transactions/find_all?credit_card_number=#{credit_card_number}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to eq transactions.first.id
    expect(json[1]["id"]).to eq transactions[1].id
    expect(json[2]["id"]).to eq transactions[2].id
  end

  it "finds all transactions by result" do
    successful_transactions = create_list(:transaction, 3, result: 0)
    failed_transactions = create_list(:transaction, 3, result: 1)

    get "/api/v1/transactions/find_all?result=success"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to eq successful_transactions.first.id
    expect(json[1]["id"]).to eq successful_transactions[1].id
    expect(json[2]["id"]).to eq successful_transactions[2].id

    get "/api/v1/transactions/find_all?result=failed"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to eq failed_transactions.first.id
    expect(json[1]["id"]).to eq failed_transactions[1].id
    expect(json[2]["id"]).to eq failed_transactions[2].id
  end

  it "finds a random transaction" do
    transaction = create_list(:transaction, 10)

    get "/api/v1/transactions/random.json"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.keys).to eq ["id", "invoice_id", "credit_card_number", "result"]
    expect(json.class).to eq Hash
  end
end
