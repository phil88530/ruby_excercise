xml.div(:class => "poductlist") do
  xml.timestamp(Time.now)

  @products.each do |product|
    xml.product do
      xml.tag!("id", product.id)
      xml.productname(product.title)
      xml.price(product.price, :currency => "USD")
    end
  end
end
