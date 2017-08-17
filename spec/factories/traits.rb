FactoryGirl.define do
  trait :with_invoice_items do
    transient do
      invoice_item_count 3
    end

    after(:create) do |object, evaluator|
      object.invoice_items << create_list(:invoice_item, evaluator.invoice_item_count)
    end
  end

  trait :with_transactions do
    transient do
      transaction_count 2
    end

    after(:create) do |object, evaluator|
      object.transactions << create_list(:transaction, evaluator.transaction_count, result: "success")
    end
  end

  trait :with_invoices do
    transient do
      invoice_count 3
    end

    after(:create) do |object, evaluator|
      object.invoices << create_list(:invoice, evaluator.invoice_count)
    end
  end
end
