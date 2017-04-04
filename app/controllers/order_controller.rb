class OrderController < ApplicationController
  def index
    shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current
    
    page = 1
    @orders = []
    count = ShopifyAPI::Order.count
    if count > 0
      page += count.divmod(250).first
      while page > 0
        @orders += ShopifyAPI::Order.find(:all, :params => {limit: 250,  order: "created_at DESC", :page => page })
        page -= 1
      end
    end
          
  end
  
  def from_category
    @orders = ShopifyAPI::Order.find(:all, :params => { :financial_status => "paid" })
    respond_to do |format|
      format.js
    end
  end
end
