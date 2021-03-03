require "test_helper"

class ProductTest < ActiveSupport::TestCase
  setup do
    @product = products(:chunky_bacon)
  end

  test "name presence" do
    @product.update(name: "")

    assert_equal({ name: ["can't be blank"] }, @product.errors.to_hash)
  end

  test "price is a number" do
    @product.update(price: "")

    assert_equal({ price: ["is not a number"] }, @product.errors.to_hash)
  end

  test "price greater than zero" do
    @product.update(price: -1.0)

    assert_equal({ price: ["must be greater than 0"] }, @product.errors.to_hash)
  end
end
