class OrdersController < ApplicationController
  before_action :set_order, only: %i(show)

  # GET /orders/new
  def new
    @order = Order.new
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: "Your order has been placed." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  private

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:token, :first_name, :last_name, :address)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end
end
