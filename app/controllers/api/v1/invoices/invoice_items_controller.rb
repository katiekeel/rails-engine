class Api::V1::Invoices::InvoiceItemsController<ApplicationController

  def show
    render json: Invoice.find(query_params[:id]).invoice_items
  end

  private

 def query_params
   params.permit(:id)
 end 
end
