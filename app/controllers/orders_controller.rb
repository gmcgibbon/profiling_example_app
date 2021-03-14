class OrdersController < ApplicationController
  before_action :set_order, only: %i(show)
  before_action :set_cart, only: %i(new)
  before_action :ensure_cart, only: %i(new)
  after_action :reset_cart, only: %i(create)
  after_action :confirm_order, only: %i(create)

  def new
    @order = Order.new
  end

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

  def show
  end

  private

  def order_params
    params.require(:order).permit(:token, :first_name, :last_name, :address).tap do |params|
      params[:cart_id] = session[:cart_id]
    end
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def ensure_cart
    redirect_to cart_path if @cart.items.none?
  end

  def reset_cart
    if @order.persisted?
      clear_cart
    else
      set_cart
    end
  end

  def confirm_order
    OrderConfirmationJob.perform_later(@order) if @order.persisted?
  end
end
