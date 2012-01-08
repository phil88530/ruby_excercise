class Product < ActiveRecord::Base
	validates :title, :uniqueness => true

	validates_presence_of :title, :description, :image_url, :price
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
	validates :image_url, :format => {
		:with => %r{\.(gif|jpg|png)$}i,
		:message => 'Image must be git,jpg or png format'
	}

end
