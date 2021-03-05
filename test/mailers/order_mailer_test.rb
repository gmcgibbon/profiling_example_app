require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  test "confirmation" do
    order = orders(:tester)

    assert_no_emails do
      OrderMailer.confirmation(order).deliver_now
    end
  end
end
