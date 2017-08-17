require 'spec_helper'

describe "Merchants BI" do
  it "returns x number of merchants in order of revenue" do
    m1, m2, m3, m4, m5 = create_list(:merchant, 5)

   get '/api/v1/merchants/most_revenue?quantity=3'

   json = JSON.parse(response.body)

   expect(response).to be_success
  end
end
