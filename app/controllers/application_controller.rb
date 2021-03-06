class ApplicationController < ActionController::Base
  private

  def set_cart
    @cart = Cart.find_by(id: session[:cart_id] ||= Cart.create!.id)
  end

  def clear_cart
    session.delete(:cart_id)
  end
end
