class ApplicationController < ActionController::Base
  before_action :authorize_profile

  private

  def authorize_profile
    Rack::MiniProfiler.authorize_request if can_profile?
  end

  def can_profile?
    request.ip == "127.0.0.1"
  end

  def set_cart
    @cart = Cart.find_by(id: session[:cart_id] ||= Cart.create!.id)
  end

  def clear_cart
    session.delete(:cart_id)
  end
end
