module OrdersHelper
  #print payment types for option
  def payment_types_option
    t_options("orders.payment_types", Order::PAYMENT_TYPES)
  end

  def t_options(prefix, options)
    options.map do |option|
      [I18n.t(prefix+'.'+option), option]
    end
  end

end
