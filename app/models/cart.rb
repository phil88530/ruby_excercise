class Cart < ActiveRecord::Base
	has_many :line_items, :dependent => :destroy #depend on if line_item exist
end
