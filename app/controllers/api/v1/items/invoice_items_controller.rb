class Api::V1::Items::InvoiceItemsController<ApplicationController

  def show
    render json: Item.find(query_params[:id]).invoice_items
  end

  private

  def query_params
    params.permit(:id)
  end
end
