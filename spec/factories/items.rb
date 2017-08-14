FactoryGirl.define do
  factory :item do
    sequence :name do |x|
      "Item #{x}"
    end

    sequence :description do |x|
      "Description #{x}"
    end

    unit_price 1
    merchant
  end
end
