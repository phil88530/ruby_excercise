class Product < ActiveRecord::Base
	default_scope :order => 'title'

	validates :title, :uniqueness => true

	validates_presence_of :title, :description, :image_url, :price, :cover_image
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01}

  #only ned to use url if we trying to load an img from online
	validates :image_url, :format => {
		:with => %r{\.(gif|jpg|png)$}i,
		:message => 'Image must be git,jpg or png format'
	}

  validates_format_of :cover_image_type, :with => /^image/, :message => "--- you can only upload pictures"

	before_destroy :ensure_not_referenced_by_any_line_item

	has_many :line_items
	has_many :orders, :through => :line_items

  def uploaded_file=(image_field)
    #raise image_field.class.inspect
    self.cover_image_type = image_field.content_type
    self.cover_image = image_field.read
  end

	#never destroy a product if still reference to any order or carts
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'can not destroy this item, item still refer to some line_items in someone\' cart')
			return false
		end
	end
end
