class Api::V1:Transaction::RandomController<ApplicationController

  def show
    render json: Transaction.order("RANDOM()").first
  end
end
