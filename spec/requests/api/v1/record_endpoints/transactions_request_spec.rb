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

  it "finds a random transaction" do
    transaction = create_list(:transaction, 10)

    get "/api/v1/transactions/random.json"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.keys).to eq ["id", "invoice_id", "credit_card_number", "result"]
    expect(json.class).to eq Hash
  end
end
