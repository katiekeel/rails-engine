class Api::V1::Invoices::CustomerController<ApplicationController

  def show
    render json: Invoice.find(query_params[:id]).customer
  end

  private

  def query_params
    params.permit(:id)
  end
end
