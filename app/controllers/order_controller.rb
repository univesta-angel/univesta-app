class OrderController < ApplicationController
  def index
    shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current
	
    if params[:start].present? && params[:end].present?
    	start = params[:start]
    	end_ = params[:end]
	@orders = ShopifyAPI.Order.find(:all, :params => { :created_at_min => start, :created_at_max => end_, :order => "created_at DESC" })
    else
	@orders = ShopifyAPI::Order.find(:all, :params => {order: "created_at DESC"})
    end
  end
  
  def from_category
    	if (params[:financial_status].present? || params[:fulfillment_status].present? || params[:order_status].present?)
  		fs = params[:financial_status]
  		fls = params[:fulfillment_status]
  		os = params[:order_status]
  		if !fs.blank? && !fls.blank? && !os.blank?
  			@orders = ShopifyAPI::Order.where(:financial_status => fs, :fulfillment_status => fls, :status => os)
  		elsif !fs.blank? && fls.blank? && os.blank?
  			@orders = ShopifyAPI::Order.where(:financial_status => fs)
  		elsif !fls.blank? && fs.blank? && os.blank?
			@orders = ShopifyAPI::Order.where(:fulfillment_status => fls)
		elsif !os.blank? && fs.blank? && fls.blank?
			@orders = ShopifyAPI::Order.where(:status => os)
		elsif !fs.blank? && !fls.blank? && os.blank?
  			@orders = ShopifyAPI::Order.where(:financial_status => fs, :fulfillment_status => fls)
  		elsif !fs.blank? && !os.blank? && fls.blank?
			@orders = ShopifyAPI::Order.where(:financial_status => fs, :status => os)
		elsif !os.blank? && !fls.blank? && fs.blank?
			@orders = ShopifyAPI::Order.where(:status => os, :financial_status => fs)
		elsif !fls.blank? && !os.blank? && fs.blank?
			@orders = ShopifyAPI::Order.where(:status => os, :fulfillment_status => fs)
		end
	else
		@orders = ShopifyAPI::Order.all
	end
    respond_to do |format|
      format.js
    end
  end
end
