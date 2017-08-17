describe "Items BI API" do
  scenario "returns the most items sold by quantity" do
    more_item = create(:item)
    less_item = create(:item)

    more_invoice_items = create_list(:invoice_item, 3, item: more_item)
    less_invoice_items = create_list(:invoice_item, 1, item: less_item)

    more_invoice = create(:invoice)
    more_invoice.invoice_items << more_invoice_items

    less_invoice = create(:invoice)
    less_invoice.invoice_items << less_invoice_items

    more_transaction = create(:transaction, result: "success")
    more_invoice.transactions << more_transaction

    less_transaction = create(:transaction, result: "success")
    less_invoice.transactions << less_transaction

    get "/api/v1/items/most_items?quantity=1"

    expect(response).to be_success
    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[0][:id]).to eq more_item.id
  end
end
