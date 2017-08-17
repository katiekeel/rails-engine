class Api::V1::Merchants::MostRevenueController<ApplicationController

  def index
    render json: Merchant.most_revenue(query_params[:quantity])
  end

  private

  def query_params
    params.permit(:quantity)
  end
end
