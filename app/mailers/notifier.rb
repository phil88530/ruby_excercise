class Notifier < ActionMailer::Base
  default from: "Phil <phil88530@gmail.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_received.subject
  #
  def order_received(order)
    @order = order
		@cart_disabled = true #disable all line_item related actions
    mail :to => order.email, :subject => 'Pragmatic Store Order Confirmation'
	end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_shipped.subject
  #
  def order_shipped(order)
    @order = order
		@cart_disabled = true #disable all line_item related actions
    mail :to => order.email, :subject => 'Pragmatic Store Order Shipped'
  end

	def cart_not_found(id)
		@id = id
    mail :to => 'support@depot.com', :subject => 'Cart Not Found Error'
	end
end
