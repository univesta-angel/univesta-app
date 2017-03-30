class OrderController < ApplicationController
  def index
    shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current
    
    #@orders = ShopifyAPI::Order.find(:all, :params => {limit: 5, order: "created_at DESC"})
    @orders = ShopifyAPI::Order.find(:all, :params => { :created_at_min => params[:start], :created_at_max => params[:end] })
    
  end
end
