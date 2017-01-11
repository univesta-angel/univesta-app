class HomeController < ShopifyApp::AuthenticatedController
  def index

    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })

  end

  def create
  	@product = ShopifyAPI::Product.new(
		{	
		  "product": {
		    "title": "Burton Custom Freestyle 151",
		    "body_html": "<strong>Good snowboard!<\/strong>",
		    "vendor": "Burton",
		    "product_type": "Snowboard",
		    "variants": [
		      {
		        "option1": "First",
		        "price": "10.00",
		        "sku": 123
		      },
		      {
		        "option1": "Second",
		        "price": "20.00",
		        "sku": "123"
		      }
		    ]
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
