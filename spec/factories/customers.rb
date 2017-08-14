FactoryGirl.define do
  factory :customer do
    sequence :first_name do |x|
      "Customer #{x}"
    end

    sequence :last_name do |x|
      "Lastname #{x}"
    end
  end
end
