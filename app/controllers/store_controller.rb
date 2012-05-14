class StoreController < ApplicationController
  skip_before_filter :authorize

  caches_page :index

  def index
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else
      unless read_fragment(:action => 'index')
		    @products = Product.all
      end
		  @cart = current_cart
		  #is session[:counter] not exist reset to 0, else +1
		  session[:counter].nil? ? session[:counter] = 0 : session[:counter]+=1
    end
	end

end
