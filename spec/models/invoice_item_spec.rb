require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  context "Validations" do
    describe "Attributes" do
      it {should validate_presence_of(:quantity)}
      it {should validate_presence_of(:unit_price)}
    end

    describe "Relationships" do
      it {should belong_to(:item)}
      it {should belong_to(:invoice)}
    end
  end
end
