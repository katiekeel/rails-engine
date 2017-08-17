describe "Items relationships API" do
  scenario "find associated invoice items" do
    item = create(:item)
    invoice_items = create_list(:invoice_item, 3, item_id: item.id)

    get "/api/v1/items/#{item.id}/invoice_items"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.count).to eq 3
    expect(json[1]["id"]).to eq item.invoice_items[1].id
  end

  scenario "finds associated merchant" do
    item = create(:item)

    get "/api/v1/items/#{item.id}/merchant"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json["id"]).to eq item.merchant.id
    expect(json.class).to eq Hash
  end
end
