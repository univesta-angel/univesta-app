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
    @notif = Notification.create(product_title: params[:title],
								product_salePrice: params[:body_html],
								product_originalPrice: params[:product_type],
								ae_productid: params[:images],
								shopify_productid: params[:vendor])
    respond_to do |format|
      if @notif.save
        format.html { redirect_to @notif, notice: 'Product was successfully imported.' }
        format.json { render :show, status: :created, location: @notif }
      else
        format.html { render :new }
        format.json { render json: @notif.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_price
  end
end
