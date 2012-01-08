require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	test "product attribute can not be empt" do
		product = Product.new
		assert product.invalid?
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:price].any?
		assert product.errors[:image_url].any?
	end

	test "product price must be positive" do
		product = Product.new(
				:title => 'alala',
				:description => 'dddd',
				:image_url => 'dsa.png')
		
		product.price = -1
		assert product.invalid?

		product.price = 0
		assert product.invalid?

		product.price = 1
		assert product.valid?
		
	end
	
	#function for create new product with image url
	def new_product(url)
		Product.new(
			:title => 'alala',
			:description => 'dddd',
			:price=> 1,
			:image_url => url)
	end

	test "image_url"  do
		ok = %w{dsa.jpg dsa.png dsa.gif DSA.JPG DSA.PNG DSA.GIF
				http://a.b.c/a/s/d/dsa.gif}

		bad = %w{dsa.doc dsa.pdf dsa.more}

		ok.each do |name|
			assert new_product(name).valid?, "#{name} must be valid"
		end

		bad.each do |name|
			assert new_product(name).invalid?, "#{name} should not be valid"
		end
	end

end
