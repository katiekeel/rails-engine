class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    render json: { "id" => Merchant.favorite_customer(params[:id]) }
  end

  private

  def query_params
    params.permit(:id)
  end

end
