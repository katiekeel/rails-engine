describe "Invoice items relationships API" do
  scenario "finds associated invoice" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.class).to eq Hash
    expect(json["id"]).to eq invoice_item.invoice.id
  end

  scenario "finds associated item" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json.class).to eq Hash
    expect(json["id"]).to eq invoice_item.item.id
  end
end
