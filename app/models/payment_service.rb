module PaymentService
  class << self
    def charge(_token)
      10_000_000.times.map do
        rand
      end # eg. some kind of expensive calculation
      true
    end
  end
end
