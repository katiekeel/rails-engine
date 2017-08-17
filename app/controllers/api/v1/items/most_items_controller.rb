class Api::V1::Items::MostItemsController < ApplicationController

  def show
    render json: Item.most_items(params[:quantity])
  end

  private

  def query_params
    params.permit(:quantity)
  end

end
