require "test_helper"

class CartTest < ActiveSupport::TestCase
  setup do
    @cart = carts(:tester)
  end

  test "has many cart items" do
    item = @cart.items.create(product: products(:chunky_bacon), amount: 2)

    assert_includes @cart.items, item
  end
end
