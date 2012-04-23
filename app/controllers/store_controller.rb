class StoreController < ApplicationController
  skip_before_filter :authorize

  def index
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else
		  @products = Product.all
		  @cart = current_cart
		  #is session[:counter] not exist reset to 0, else +1
		  session[:counter].nil? ? session[:counter] = 0 : session[:counter]+=1
    end
	end

end
