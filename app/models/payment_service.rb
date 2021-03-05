class PaymentService
  def self.charge(_token)
    sleep(5) # simulate a slow payment capture
    true
  end
end
