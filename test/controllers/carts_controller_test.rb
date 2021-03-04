require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  test "should update cart" do
    assert_difference('Cart.count') do
      assert_difference('Cart::Item.count') do
        put cart_url, params: {
          cart: {
            items_attributes: [{
              product_id: products(:chunky_bacon).id,
              amount: 26,
            }],
          },
        }
      end
    end

    assert_redirected_to cart_url

    assert_no_difference('Cart.count') do
      assert_no_difference('Cart::Item.count') do
        assert_difference('Cart::Item.last.amount') do
          put cart_url, params: {
            cart: {
              items_attributes: [{
                id: Cart::Item.last.id,
                product_id: products(:chunky_bacon).id,
                amount: 27,
              }],
            },
          }
        end
      end
    end

    assert_redirected_to cart_url

    assert_no_difference('Cart.count') do
      assert_difference('Cart::Item.count', -1) do
        put cart_url, params: {
          cart: {
            items_attributes: [{
              id: Cart::Item.last.id,
              _destroy: true,
            }],
          },
        }
      end
    end

    assert_redirected_to cart_url

    put cart_url, headers: {
      "HTTP_REFERER": products_url
    }, params: {
      cart: {
        items_attributes: [{
          product_id: products(:chunky_bacon).id,
          amount: 1,
        }],
      },
    }

    assert_redirected_to products_url
  end

  test "should show cart" do
    assert_difference('Cart.count') do
      get cart_url
      assert_response :success
    end
  end
end
