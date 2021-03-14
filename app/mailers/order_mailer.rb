class OrderMailer < ApplicationMailer
  def confirmation(order)
    @order = order
    10_000_000.times.map do
      rand
    end # eg. slow mail server send
  end
end
