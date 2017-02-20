class OrderController < ShopifyApp::AuthenticatedController
  def index
    
      @orders = ShopifyAPI::Order.find(:all)

  end
end
