class HomeController < ShopifyApp::AuthenticatedController
  def index
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @posts = Product.all
  	if params[:search]
    	@posts = Product.search(params[:search]).order("created_at DESC")
  	else
    	@posts = Product.all.order('created_at DESC')
  	end
  end
end
