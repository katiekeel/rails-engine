describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items.json'

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq 3
  end

  it "can get one item by id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq id
  end

  it "finds one item by id" do
    item = create(:item)

    get "/api/v1/items/find?id=#{item.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq item.id
  end

  it "finds one item by name" do
    item = create(:item)

    get "/api/v1/items/find?name=#{item.name}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["name"]).to eq item.name
  end

  it "finds one item by description" do
    item = create(:item)

    get "/api/v1/items/find?description=#{item.description}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["description"]).to eq item.description
  end

  it "finds one item by created at" do
    item = create(:item, created_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/items/find?created_at=2012-03-27T14:54:05.000Z"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq item.id
  end

  it "finds one item by updated at" do
    item = create(:item, updated_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/items/find?updated_at=2012-03-27T14:54:05.000Z"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq item.id
  end

  context "Case insensitive" do
    it "finds one item by name" do
      item = create(:item)

      get "/api/v1/items/find?name=#{item.name.downcase}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["name"]).to eq item.name

      get "/api/v1/items/find?name=#{item.name.upcase}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["name"]).to eq item.name
    end

    it "finds one item by description" do
      item = create(:item)

      get "/api/v1/items/find?description=#{item.description.downcase}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["description"]).to eq item.description

      get "/api/v1/items/find?description=#{item.description.upcase}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json["description"]).to eq item.description
    end
  end

  it "finds one item by unit price" do
    item = create(:item, unit_price: "0.55")

    get "/api/v1/items/find?unit_price=#{item.unit_price}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["unit_price"]).to eq "0.55"
  end

  it "finds one item by merchant id" do
    item = create(:item)

    get "/api/v1/items/find?merchant_id=#{item.merchant_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["merchant_id"]).to eq item.merchant_id
  end

  it "finds all items by name" do
    item_1 = create(:item, name: "Item")
    item_2 = create(:item, name: "Item")
    item_3 = create(:item, name: "Item")

    get "/api/v1/items/find_all?name=Item"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 3
    expect(json.first["name"]).to eq item_1.name
    expect(json[1]["name"]).to eq item_2.name
    expect(json[2]["name"]).to eq item_3.name
  end

  it "finds all items by description" do
    item_1 = create(:item, name: "Item", description: "First item")
    item_2 = create(:item, name: "Item", description: "Third item")
    item_3 = create(:item, name: "Item", description: "Third item")

    get "/api/v1/items/find_all?name=Item"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 3
    expect(json.first["description"]).to eq item_1.description
    expect(json[1]["description"]).to eq item_2.description
    expect(json[2]["description"]).to eq item_3.description
  end

  context "Case Insensitive" do
    it "finds all items by name" do
      item_1 = create(:item, name: "Item")
      item_2 = create(:item, name: "Item")
      item_3 = create(:item, name: "Item")

      get "/api/v1/items/find_all?name=item"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq 3
      expect(json.first["name"]).to eq item_1.name
      expect(json[1]["name"]).to eq item_2.name
      expect(json[2]["name"]).to eq item_3.name
    end

    it "finds all items by description" do
      item_1 = create(:item, name: "Item", description: "ITEM")
      item_2 = create(:item, name: "Item", description: "ITEM")
      item_3 = create(:item, name: "Item", description: "ITEM")

      get "/api/v1/items/find_all?description=ITEM"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json.count).to eq 3
      expect(json.first["description"]).to eq item_1.description
      expect(json[1]["description"]).to eq item_2.description
      expect(json[2]["description"]).to eq item_3.description
    end
  end

  it "finds all items by unit price" do
    items = create_list(:item, 3, unit_price: "0.55")

    get "/api/v1/items/find_all?unit_price=0.55"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 3

    expect(json.first["unit_price"]).to eq "0.55"
    expect(json[1]["unit_price"]).to eq "0.55"
    expect(json[2]["unit_price"]).to eq "0.55"
  end

  it "finds all items by merchant id" do
    merchant = create(:merchant)
    items = create_list(:item, 3, merchant: merchant)

    get "/api/v1/items/find_all?merchant_id=#{merchant.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 3
    expect(json[0]["merchant_id"]).to eq merchant.id
    expect(json[1]["merchant_id"]).to eq merchant.id
    expect(json[2]["merchant_id"]).to eq merchant.id
  end

  it "finds all items by created at" do
    items = create_list(:item, 3, created_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/items/find_all?created_at=2012-03-27T14:54:05.000Z"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to eq items.first.id
    expect(json[1]["id"]).to eq items[1].id
    expect(json[2]["id"]).to eq items[2].id
  end

  it "finds all items by updated at" do
    items = create_list(:item, 3, updated_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/items/find_all?updated_at=2012-03-27T14:54:05.000Z"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to eq items.first.id
    expect(json[1]["id"]).to eq items[1].id
    expect(json[2]["id"]).to eq items[2].id
  end

  it "finds a random item" do
    items = create_list(:item, 3)

    get "/api/v1/items/random.json"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json).to be_a(Hash)
    expect(Item.find(json["id"])).to be_a(Item)
  end
end
