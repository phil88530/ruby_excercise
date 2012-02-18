class Product < ActiveRecord::Base
	default_scope :order => 'title'

	validates :title, :uniqueness => true

	validates_presence_of :title, :description, :image_url, :price
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
	validates :image_url, :format => {
		:with => %r{\.(gif|jpg|png)$}i,
		:message => 'Image must be git,jpg or png format'
	}

	before_destroy :ensure_not_referenced_by_any_line_item

	has_many :line_items

	#never destroy a product if still reference to any order or carts
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			error.add(:base, 'can not destroy this item, item still refer to some line_items in someone\' cart')
			return false
		end
	end
end
