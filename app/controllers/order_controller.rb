class OrderController < ApplicationController
  def index
    shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current
    
    count = ShopifyAPI::Order.find(:count)
    pages = count % 250
    1.upto(pages) do |page|
      @orders = ShopifyAPI::Order.find(:all, params: {limit: 250, page: page})
    end
    
  end
end
