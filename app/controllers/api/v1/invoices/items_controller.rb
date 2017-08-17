class Api::V1::Invoices::ItemsController<ApplicationController

  def show
    render json: Invoice.find(query_params[:id]).items
  end

  private

  def query_params
    params.permit(:id)
  end
end
