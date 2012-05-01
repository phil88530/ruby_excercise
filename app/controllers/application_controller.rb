class ApplicationController < ActionController::Base
  before_filter :set_i18n_locale_from_params, :authorize
  protect_from_forgery

  #throw error when auth-token not match
  def handle_unverified_request
    redirect_to root_url, :notice => "We detect unmatching token form your form, please do not hack us"
    
  end

	private
	def current_cart
		Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
		cart = Cart.create
		session[:cart_id] = cart.id
		cart
	end

  protected
  #authorize user login
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
    end
  end

  #set default language
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    { :locale => I18n.locale}
  end

end
