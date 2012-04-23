module ApplicationHelper
	def hidden_div_if(condition, attributes={}, &block)
		if condition
			attributes["style"] = "display:none"
		end
		content_tag("div", attributes, &block)
	end

  def t_currency(price)
    number_to_currency(price * (I18n.locale.to_s == 'es' ? 1.3 : 1))
  end
end
