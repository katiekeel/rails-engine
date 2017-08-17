class Api::V1::Invoices::TransactionsController < ApplicationController

  def show
    render json: Invoice.find(params[:id]).transactions
  end

  private

  def query_params
    params.permit(:id)
  end
end
