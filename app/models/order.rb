class Order < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy
  encrypt(:name, :email)

  PAYMENT_TYPES = ["cheque", "credit_card", "purchase_order"]


	validates :name, :address, :email, :pay_type, :presence => true
	validates :pay_type, :inclusion => PAYMENT_TYPES, :on => :create

	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			#add this item to this current order's line_items list
			line_items << item
		end
	end

	def mark_shipped
		self.ship_date = Time.now
		if self.save!
			Notifier.order_shipped(self).deliver!
		end
	end
end
