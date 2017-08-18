require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context "Validations" do
    describe "Attributes" do
      it {should validate_presence_of(:credit_card_number)}
      it {should validate_presence_of(:result)}
      it {should validate_numericality_of(:credit_card_number)}
      it {should define_enum_for(:result)}
    end

    describe "Relationships" do
      it {should belong_to(:invoice)}
      it {should have_many(:invoice_items)}
      it {should have_one(:customer)}
      it {should have_one(:merchant)}
    end
  end
end
