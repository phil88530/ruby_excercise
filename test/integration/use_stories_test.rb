require 'test_helper'

class UseStoriesTest < ActionDispatch::IntegrationTest
	fixtures :products	#load all fixtures

	test "buying a product" do	
		#init testing environment
		LineItem.delete_all
		Order.delete_all
		ruby_book = products(:ruby)

		#user go to index
		get "/"
		assert_response :success
		assert_template "index"

		#select a product
		xml_http_request :post, '/line_items', :product_id => ruby_book.id
		assert_response :success

		cart = Cart.find(session[:cart_id])
		assert_equal 1, cart.line_items.size
		assert_equal ruby_book, cart.line_items[0].product

		#user checkout
		get "/orders/new"
		assert_response :success
		assert_template "new"

		#fill in checkout form
		post_via_redirect "/orders", :order => {:name	=> "Phil",
																					 	:address	=> "Address 123",
																						:email	=> "phil88530@hotmail.com",
																						:pay_type	=> "Check"}
		assert_response :success
		assert_template	"index"
		cart = Cart.find(session[:cart_id])
		assert_equal 0, cart.line_items.size
																						
		#check db to see we actually got this order
		orders = Order.all
		assert_equal 1, orders.size
		order = orders[0]

		assert_equal "Phil", order.name
		assert_equal "Address 123", order.address
		assert_equal "phil88530@hotmail.com", order.email
		assert_equal "Check", order.pay_type
		
		assert_equal 1, order.line_items.size
		line_item = order.line_items[0]
		assert_equal ruby_book, line_item.product

		#email also sent to the right place
		mail = ActionMailer::Base.deliveries.last
		assert_equal ["phil88530@hotmail.com"], mail.to
		assert_equal 'Phil <phil88530@gmail.com>', mail[:from].value
		assert_equal 'Pragmatic Store Order Confirmation', mail.subject

		#ship item
		order.mark_shipped
		mail = ActionMailer::Base.deliveries.last
		assert_equal ["phil88530@hotmail.com"], mail.to
		assert_equal 'Phil <phil88530@gmail.com>', mail[:from].value
		assert_equal 'Pragmatic Store Order Shipped', mail.subject
	end
end
