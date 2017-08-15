describe "Merchants` API" do
  it "sends a list of items" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_success

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchant["id"]).to eq(id)
  end

  it "finds one item by merchant_id " do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(merchant.id)
  end

  it "finds one item by name" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["name"]).to eq merchant.name
  end

  context "Case insensitive" do
    it "finds one merchant by name" do
      merchant = create(:merchant)

      get "/api/v1/merchants/find?name=#{merchant.name.downcase}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["name"]).to eq merchant.name

      get "/api/v1/merchants/find?name=#{merchant.name.upcase}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["name"]).to eq merchant.name
    end
  end

  it "finds all items by name" do
    merchants = create_list(:merchant, 5, name: "Super")

    get "/api/v1/merchants/find_all?name=#{merchants[1].name}"
    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 5 
    expect(json.first["id"]).to eq merchants[0].id
    expect(json[1]["name"]).to eq "Super"
   end
end


