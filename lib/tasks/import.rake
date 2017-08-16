require 'csv'

counter = 0

desc "Import csv data"
task :import => [:environment] do

  customers = "db/customers.csv"

  CSV.foreach(customers, :headers => true) do |row|
    Customer.create!({
      :first_name => row[1],
      :last_name => row[2],
      :created_at => row[3],
      :updated_at => row[4]
    })
    puts counter += 1
  end

  merchants = "db/merchants.csv"

  CSV.foreach(merchants, :headers => true) do |row|
    Merchant.create!({
      :name => row[1],
      :created_at => row[2],
      :updated_at => row[3]
    })
    puts counter += 1
  end

  items = "db/items.csv"

  CSV.foreach(items, :headers => true) do |row|
    Item.create!({
      :name => row[1],
      :description => row[2],
      :unit_price => '%.2f' % (row[3].to_i/100.0),
      :merchant_id => row[4],
      :created_at => row[5],
      :updated_at => row[6]
    })
    puts counter += 1
  end

  invoices = "db/invoices.csv"

  CSV.foreach(invoices, :headers => true) do |row|
    Invoice.create!({
      :customer_id => row[1],
      :merchant_id => row[2],
      :status => row[3],
      :created_at => row[4],
      :updated_at => row[5]
    })
    puts counter += 1
  end

  invoice_items = "db/invoice_items.csv"

  CSV.foreach(invoice_items, :headers => true) do |row|
    InvoiceItem.create!({
      :item_id => row[1],
      :invoice_id => row[2],
      :quantity => row[3],
      :unit_price => '%.2f' % (row[4].to_i/100.0),
      :created_at => row[5],
      :updated_at => row[6]
    })
    puts counter += 1
  end

  transactions = "db/transactions.csv"

  CSV.foreach(transactions, :headers => true) do |row|
    Transaction.create!({
      :invoice_id => row[1],
      :credit_card_number => row[2],
      :result => row[4],
      :created_at => row[5],
      :updated_at => row[6]
    })
    puts counter += 1
  end

end
