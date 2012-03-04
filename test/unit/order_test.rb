require 'test_helper'

class OrderTest < ActiveSupport::TestCase
	test "update an order to become shipped" do
		order = orders(:one)
		order.mark_shipped
		mail_size = ActionMailer::Base.deliveries.size
		assert_equal 1, mail_size
	end
end
