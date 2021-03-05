class OrderMailer < ApplicationMailer
  def confirmation(order)
    @order = order
    sleep(5) # simulate slow mail server send
  end
end
