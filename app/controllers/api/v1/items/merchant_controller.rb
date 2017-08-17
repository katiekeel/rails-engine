class Api::V1::Items::MerchantController<ApplicationController

  def show
    render json: Item.find(query_params[:id]).merchant
  end

  private

  def query_params
    params.permit(:id)
  end
end
