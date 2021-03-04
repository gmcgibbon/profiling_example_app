class CartsController < ApplicationController
  before_action :set_cart, only: %i(update show)

  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_back fallback_location: cart_url, notice: "Updated cart" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  private

  def cart_params
    params.require(:cart).permit(items_attributes: %i(id product_id amount _destroy))
  end

  def set_cart
    @cart = Cart.find_by(id: session[:cart_id] ||= Cart.create!.id)
  end
end
