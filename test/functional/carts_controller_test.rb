require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  setup do
    @cart = Cart.create
		@book_one = products(:ruby)
		@book_two = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cart" do
    assert_difference('Cart.count') do
      post :create, :cart => @cart.attributes
    end

    assert_redirected_to cart_path(assigns(:cart))
  end

  test "should show cart" do
    get :show, :id => @cart.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @cart.to_param
    assert_response :success
  end

  test "should update cart" do
    put :update, :id => @cart.to_param, :cart => @cart.attributes
    assert_redirected_to cart_path(assigns(:cart))
  end

	test "can't delete product in cart" do
		assert_difference('Product.count', 0) do
			delete :destroy, :id => products(:ruby).to_param
		end
	end

  test "should destroy cart" do
    assert_difference('Cart.count', -1) do
			session[:cart_id] = @cart.id
      delete :destroy, :id => @cart.to_param
    end

    assert_redirected_to store_path
  end

	#ajax testing for clear cart
	test "should remove cart via ajax" do
    assert_difference('Cart.count', -1) do
			session[:cart_id] = @cart.id
			xhr :post, :destroy, :id => @cart.id
    end

		assert_response :success
	end

	test "add unique products to cart" do
		@cart.add_product(@book_one.id).save!
		@cart.add_product(@book_two.id).save!
		assert_equal 2, @cart.line_items.size
		assert_equal @book_one.price + @book_two.price, @cart.total_price
	end

	test "add duplicate productgs to cart" do
		@cart.add_product(@book_one.id).save!
		@cart.add_product(@book_one.id).save!
		assert_equal 1, @cart.line_items.size
		assert_equal @book_one.price * 2, @cart.total_price
		assert_equal 2, @cart.line_items[0].quantity
	end
end
