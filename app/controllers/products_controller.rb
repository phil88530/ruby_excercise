class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @products }
      format.xml
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        expire_index_caches

        format.html { redirect_to @product, :notice => 'Product was successfully created.' }
        format.json { render :json => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        expire_index_caches

        format.html { redirect_to @product, :notice => 'Product was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.destroy
        expire_index_caches

        format.html { redirect_to products_url }
        format.json { head :ok }
      end
    end
  end
	
	def who_bought
		@product = Product.find(params[:id])
		respond_to do |format|
			format.atom
			format.xml{render :xml => @product}
		end
	end

  #send the picture from request
  def picture
    @product = Product.find(params[:id])
    send_data(@product.cover_image,
      :filename => @product.title,
      :type => @product.cover_image_type,
      :disposition => "inline")
  end

  private
  def expire_index_caches
    #expire the index pages cache
    expire_page :action => "index"

    #expire client cache when list has changed
    expire_fragment(:controller => "store", :action => "index")
  end
end
