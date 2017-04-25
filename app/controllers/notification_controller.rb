class NotificationController < ApplicationController
  wrap_parameters format: [:json]

  def index
  	#shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
	#ShopifyAPI::Base.site = shop_url
	#shop = ShopifyAPI::Shop.current
  	
  	@notifs = Notification.all.order(created_at: :desc)
  	
  	markup = Markup.find(2)
  	@pmu = markup.price

  end

  def create_notif
    @notif = Notification.create(product_title: params[:product_title],
								product_salePrice: params[:product_salePrice],
								product_originalPrice: params[:product_originalPrice],
								ae_productid: params[:ae_productid],
								shopify_productid: params[:shopify_productid])
  end

  def update_price
  end
end
