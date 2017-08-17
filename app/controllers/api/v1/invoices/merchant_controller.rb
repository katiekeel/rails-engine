class Api::V1::Invoices::MerchantController<ApplicationController

  def show
    render json: Invoice.find(query_params[:id]).merchant
  end

  private

  def query_params
    params.permit(:id)
  end
end
