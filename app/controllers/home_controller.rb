class HomeController < ShopifyApp::AuthenticatedController
  wrap_parameters format: [:json]

  def index
    #@products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @products = ShopifyAPI::Product.find(:all)
    
  end

end
