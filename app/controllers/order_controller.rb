class OrderController < ApplicationController
  def index
    shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current
    
    count = GET /admin/orders/count.json
    page_size = 250

    pages = ceiling(count / 250.0)

    current_page = 1
    @orders = []

    while(current_page <= pages)
      @products += GET /admin/orders.json?limit=250&page=current_page
      current_page += 1
    end
    
  end
end
