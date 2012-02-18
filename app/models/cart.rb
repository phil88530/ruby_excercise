class Cart < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy #depend on if line_item exist

	#add a product to cart, if exist, add the quantity instead
	def add_product(product_id)
		current_item = line_items.find_by_product_id(product_id)
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(:product_id => product_id)
		end
		current_item
	end

	#count total price of all items
	def total_price
		line_items.to_a.sum{|item| item.total_price}
	end
end
