require 'spec_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_success

    json = JSON.parse(response.body)

    expect(json.count).to eq(3)
  end

  it "can get one customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(id)
  end

  it "finds one customer by merchant_id " do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(customer.id)
  end

  it "finds one customer by name" do
    customer = create(:customer)

    get "/api/v1/customers/find?name=#{customer.first_name}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["last_name"]).to eq customer.last_name
  end

  context "Case insensitive" do
    it "finds one customer by first_name" do
      customer = create(:customer)

      get "/api/v1/customers/find?first_name=#{customer.first_name.downcase}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["last_name"]).to eq customer.last_name

      get "/api/v1/customers/find?first_name=#{customer.first_name.upcase}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["first_name"]).to eq customer.first_name
    end
  end

  it "finds all customers by name" do
    customer = create_list(:customer, 5, first_name: "Super")

    get "/api/v1/customers/find_all?first_name=#{customer[1].first_name}"
    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 5
    expect(json.first["id"]).to eq customer[0].id
    expect(json[1]["first_name"]).to eq "Super"
  end

  it "finds a random customer" do
    customer = create_list(:customer, 10)

    get "/api/v1/customers/random.json"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.keys).to eq ["id", "first_name", "last_name"]
    expect(json.class).to eq Hash
  end
end

