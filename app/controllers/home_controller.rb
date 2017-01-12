class HomeController < ShopifyApp::AuthenticatedController
  def index

    #@products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @products = ShopifyAPI::Product.find(:all, params: {collection_id: 401443728})
    
  end

  def create
  	@product = ShopifyAPI::Product.create(
		{	
		  "product": {
		    "title": params[:title],
		    "vendor": params[:vendor]
		  }
		})

  	respond_to do |format|
      if @product.save
        format.json { render json: 201 }
      else
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end

  end

end
