class HomeController < ShopifyApp::AuthenticatedController
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @products = Product.all
  	if params[:search]
    	@products = Product.search(params[:search]).order("created_at DESC")
  	else
    	@products = Product.all.order('created_at DESC')
  	end
  end
end
