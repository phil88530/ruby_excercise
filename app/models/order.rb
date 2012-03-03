class Order < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy

	PAYMENT_TYPES = ["Check", "Cridit card", "Purchase order"]

	validates :name, :address, :email, :pay_type, :presence => true
	validates :pay_type, :inclusion => PAYMENT_TYPES

	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			#add this item to this current order's line_items list
			line_items << item
		end
	end
end
