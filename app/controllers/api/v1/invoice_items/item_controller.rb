class Api::V1::InvoiceItems::ItemController<ApplicationController

  def show
    render json: InvoiceItem.find(query_params[:id]).item
  end

  private

  def query_params
    params.permit(:id)
  end
end
