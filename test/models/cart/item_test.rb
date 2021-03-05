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

  test "#price" do
    stylish_beret = Product.create!(name: "Stylish Beret", price: 134.67)
    cart_item = carts(:tester).items.create!(product: stylish_beret, amount: 16)

    assert_equal BigDecimal(2154.72, 6), cart_item.price
  end
end
