require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:tester)
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    put cart_url, params: {
      cart: {
        items_attributes: [{
          product_id: products(:chunky_bacon).id,
          amount: 1,
        }]
      }
    }
    assert_difference('Order.count') do
      post orders_url, params: {
        order: {
          token: SecureRandom.uuid,
          first_name: "Tester",
          last_name: "Testington",
          address: "123 Fake St.",
        }
      }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end
end
