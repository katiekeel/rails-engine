require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context "Validations" do
    describe "Attributes" do
      it {should validate_presence_of(:name)}
    end

    describe "Relationships" do
      it {should have_many(:items)}
      it {should have_many(:invoices)}
    end
  end
end
