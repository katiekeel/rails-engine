describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items.json'

    expect(response).to be_success

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end

  it "can get one item by id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["id"]).to eq(id)
  end

  it "finds one item by id" do
    item = create(:item)

    get "/api/v1/items/find?id=#{item.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq(item.id)
  end

  xit "finds one item by name" do

  end

  xit "finds one item by description" do

  end

  context "Case insensitive" do
    xit "finds one item by name" do

    end

    xit "finds one item by description" do

    end
  end

  xit "finds one item by unit price" do

  end

  xit "finds one item by merchant id" do

  end

  it "finds all items by name" do
    item_1 = create(:item, name: "Item")
    item_2 = create(:item, name: "Item")
    item_3 = create(:item, name: "Item", description: "Third item")

    get "/api/v1/items/find_all?name=#{Item}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 3
    expect(json.first["id"]).to eq item_1.id
    expect(json[1]["name"]).to eq "Item"
    expect(json[2]["description"]).to eq "Third item"
  end

  xit "finds all items by description" do

  end

  context "Case Insensitive" do
    xit "finds all items by name" do

    end
    
    xit "finds all items by description" do

    end
  end

  xit "finds all items by unit price" do

  end

  xit "finds all items by merchant id" do

  end

  xit "finds all items by created at" do

  end

  xit "finds all items by updated at" do

  end

  xit "finds a random item" do

  end
end
