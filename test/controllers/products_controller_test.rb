require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:chunky_bacon)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end
end
