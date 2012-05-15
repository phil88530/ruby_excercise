module ApplicationHelper
	def hidden_div_if(condition, attributes={}, &block)
		if condition
			attributes["style"] = "display:none"
		end
		content_tag("div", attributes, &block)
	end

  #print price is 1.3 times if language and price is set to spanish
  def t_currency(price)
    number_to_currency(price * (I18n.locale.to_s == 'es' ? 1.3 : 1))
  end

  #define 7 days of a week
  DAYNAMES = %w{Sunday Monday Tuesday Wednesday Thursday Friday Saturday}
  def print_weekday
    DAYNAMES[Date.today.wday]
  end
end
