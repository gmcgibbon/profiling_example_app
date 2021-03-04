require "test_helper"

class OrderTest < ActiveSupport::TestCase
  setup do
    @order = orders(:tester)
  end

  test "cart presence" do
    @order.update(cart: nil)

    assert_equal({ cart: ["must exist"] }, @order.errors.to_hash)
  end

  test "token presence" do
    @order.update(token: "")

    assert_equal({ token: ["can't be blank"] }, @order.errors.to_hash)
  end

  test "token uniqueness" do
    token = SecureRandom.uuid
    @order.dup.update!(token: token)

    @order.update(token: token)

    assert_equal({ token: ["has already been taken"] }, @order.errors.to_hash)
  end

  test "first_name presence" do
    @order.update(first_name: "")

    assert_equal({ first_name: ["can't be blank"] }, @order.errors.to_hash)
  end

  test "last_name presence" do
    @order.update(last_name: "")

    assert_equal({ last_name: ["can't be blank"] }, @order.errors.to_hash)
  end

  test "address presence" do
    @order.update(address: "")

    assert_equal({ address: ["can't be blank"] }, @order.errors.to_hash)
  end
end
