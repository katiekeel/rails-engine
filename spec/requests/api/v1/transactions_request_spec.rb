describe "Transactions Api" do
  it "sends a list of transactions" do
    create_list(:transaction, 3)

    get 'api/v1/transactions'

    expect(response).to be_success

    json = JSON.parse(response.body)

    expect(json.count).to eq(3)
  end

  xit "can get one transaction by its id" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(id)
  end

  xit "finds one transaction by transaction_id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction}.id"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["name"]).to eq merchant.name
  end

  xit "finds one transaction by credit card number" o
    transaction = create(:transaction)

    get "/api/v1/transactions/find?invoice_id=#{transaction.credit_card_number}"

    json= = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["credit_card_number"]).to eq transaction.credit_card_number
  end


end


