class OrderConfirmationJob < ApplicationJob
  queue_as :default

  def perform(order)
    PaymentService.charge(order.token)
    OrderMailer.confirmation(order).deliver_now
  end
end
