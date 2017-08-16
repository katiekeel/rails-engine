class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    render json: {"revenue" => Merchant.revenue_by_date(params[:id], query_params[:date])} unless query_params[:date].nil?
    render json: {"revenue" => Merchant.revenue(params[:id])} if query_params[:date].nil?
  end

  private

  def query_params
    params.permit(:id, :date)
  end

end
