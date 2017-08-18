class Api::V1::InvoiceItems::InvoiceController<ApplicationController

  def show
    render json: InvoiceItem.find(query_params[:id]).invoice
  end

  private

  def query_params
    params.permit(:id)
  end
end
