class HomeController < ShopifyApp::AuthenticatedController
  wrap_parameters format: [:json]

  def index
  	shop_url = "https://#{API_KEY}:#{PASSWORD}@SHOP_NAME.myshopify.com/admin"
	ShopifyAPI::Base.site = shop_url
    #@products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @products = ShopifyAPI::Product.find(:all, params: {collection_id: 401443728})
    
  end

end
