require "test_helper"

class PaymentServiceTest < ActiveSupport::TestCase
  test ".charge" do
    token = SecureRandom.uuid

    assert_operator PaymentService, :charge, token
  end
end
