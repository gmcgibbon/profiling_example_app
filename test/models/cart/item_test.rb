require "test_helper"

class Cart::ItemTest < ActiveSupport::TestCase
  setup do
    @cart_item = cart_items(:chunky_bacon)
  end

  test "cart presence" do
    @cart_item.update(cart: nil)

    assert_equal({ cart: ["must exist"] }, @cart_item.errors.to_hash)
  end

  test "product presence" do
    @cart_item.update(product: nil)

    assert_equal({ product: ["must exist"] }, @cart_item.errors.to_hash)
  end

  test "amount is a number" do
    @cart_item.update(amount: "")

    assert_equal({ amount: ["is not a number"] }, @cart_item.errors.to_hash)
  end

  test "amount greater than zero" do
    @cart_item.update(amount: -1)

    assert_equal({ amount: ["must be greater than 0"] }, @cart_item.errors.to_hash)
  end
end
