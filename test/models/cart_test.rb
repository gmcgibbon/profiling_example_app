require "test_helper"

class CartTest < ActiveSupport::TestCase
  setup do
    @cart = carts(:tester)
  end

  test "has many cart items" do
    item = @cart.items.create!(product: products(:chunky_bacon), amount: 2)

    assert_includes @cart.items, item
  end

  test "#price" do
    cart = Cart.create!
    rocket_shoes = Product.create!(name: "Rocket Shoes", price: 350.74)
    invisible_ink = Product.create!(name: "Invisible Ink", price: 20.56)

    cart.items.create!(product: rocket_shoes, amount: 2)
    cart.items.create!(product: invisible_ink, amount: 15)

    assert_equal BigDecimal(1009.88, 6), cart.price
  end
end
