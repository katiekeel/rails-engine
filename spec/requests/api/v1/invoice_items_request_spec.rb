describe "Invoice Items API" do
  it "sends a list of invoice_items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items.json'

    expect(response).to be_success

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(3)
  end

  it "can get one invoice_item by id" do
    id = create(:invoice_item).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["id"]).to eq id
  end

  it "finds one invoice_item by id" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq invoice_item.id
  end

  it "finds one invoice_item by item id" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq invoice_item.id
  end

  it "finds one invoice_item by invoice_id" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["invoice_id"]).to eq invoice_item.invoice_id
  end

  it "finds one invoice_item by quantity" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["quantity"]).to eq invoice_item.quantity
  end

  it "finds one invoice_item by unit_price" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/find?unit_price=#{invoice_item.unit_price}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq invoice_item.id
  end

  it "finds one invoice_item by created at" do
    invoice_item = create(:invoice_item, created_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/invoice_items/find?created_at=2012-03-27T14:54:05.000Z"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq invoice_item.id
  end

  it "finds one invoice_item by updated at" do
    invoice_item = create(:invoice_item, updated_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/invoice_items/find?updated_at=2012-03-27T14:54:05.000Z"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq invoice_item.id
  end

  it "finds all invoice_items by invoice_id" do
    invoice = create(:invoice)
    invoice_item_1 = create(:invoice_item, invoice: invoice)
    invoice_item_2 = create(:invoice_item, invoice: invoice)
    invoice_item_3 = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 3
    expect(json.first["invoice_id"]).to eq invoice_item_1.invoice_id
    expect(json[1]["invoice_id"]).to eq invoice_item_2.invoice_id
    expect(json[2]["invoice_id"]).to eq invoice_item_3.invoice_id
  end

  it "finds all invoice_items by quantity" do
    invoice_items = create_list(:invoice_item, 3, quantity: 3)

    get "/api/v1/invoice_items/find_all?quantity=3"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 3
    expect(json[0]["quantity"]).to eq 3
    expect(json[1]["quantity"]).to eq 3
    expect(json[2]["quantity"]).to eq 3
  end

  it "finds all invoice_items by created at" do
    invoice_items = create_list(:invoice_item, 3, created_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/invoice_items/find_all?created_at=2012-03-27T14:54:05.000Z"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to eq invoice_items.first.id
    expect(json[1]["id"]).to eq invoice_items[1].id
    expect(json[2]["id"]).to eq invoice_items[2].id
  end

  it "finds all invoice_items by updated at" do
    invoice_items = create_list(:invoice_item, 3, updated_at: "2012-03-27 14:54:05 UTC")

    get "/api/v1/invoice_items/find_all?updated_at=2012-03-27T14:54:05.000Z"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json[0]["id"]).to eq invoice_items.first.id
    expect(json[1]["id"]).to eq invoice_items[1].id
    expect(json[2]["id"]).to eq invoice_items[2].id
  end

  it "finds a random invoice_item" do
    invoice_items = create_list(:invoice_item, 3)

    get "/api/v1/invoice_items/random.json"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json).to be_a(Hash)
    expect(InvoiceItem.find(json["id"])).to be_a(InvoiceItem)
  end
end
