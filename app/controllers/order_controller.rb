class OrderController < ApplicationController
  def index
    shop_url = "https://77d56bcf8d3ab9647b85d9030f2b1e1b:22c7a88a600583dea6c121fcb9eb1daf@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current

    @orders = ShopifyAPI::Order.find(:all, :params => { :order => "created_at DESC" })   
    @shopsession = "77d56bcf8d3ab9647b85d9030f2b1e1b:22c7a88a600583dea6c121fcb9eb1daf@gels-store.myshopify.com"
    
  end
  
  def from_category
  	shop_url = "https://77d56bcf8d3ab9647b85d9030f2b1e1b:22c7a88a600583dea6c121fcb9eb1daf@gels-store.myshopify.com/admin"
	ShopifyAPI::Base.site = shop_url
	shop = ShopifyAPI::Shop.current
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
    	elsif params[:from].present? && params[:to].present?
		from = params[:from].to_date.beginning_of_day
		to = params[:to].to_date.end_of_day
		@orders = ShopifyAPI::Order.find(:all, :params => { :created_at_min => from, :created_at_max => to })	
	else
		@orders = ShopifyAPI::Order.find(:all, :params => {order: "created_at DESC"})
  	end
    respond_to do |format|
      format.js
    end
  end
	
  def edit_note
	if params[:note].present? && params[:order_id].present?
		note = params[:note]
		orderid = params[:order_id]
  		order = ShopifyAPI::Order.find(orderid)
  		order.note = note
  		order.save
  	end
  end
	
  def mark_shipped
  	shop_url = "https://77d56bcf8d3ab9647b85d9030f2b1e1b:22c7a88a600583dea6c121fcb9eb1daf@gels-store.myshopify.com/admin"
	ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current
    if params[:order_id].present?

      	orderid = params[:order_id]   
      	order = ShopifyAPI::Order.find(orderid)
      
	  	order.line_items.map(&:id).each do |li_id|
	    #attrs = { "notify_customer": false, "tracking_number": nil, "line_items": [{"id": li_id}], "status": "success" }
	    #api.post("/admin/orders/#{order.id}/fulfillments.json", { "fulfillment": attrs })
	    f = ShopifyAPI::Fulfillment.new(:order_id => order.id, :notify_customer => false ,:tracking_number => nil, :line_items =>[ {"id" => li_id} ])
	    f.prefix_options = { :order_id => order.id }
	    f.save
     end
		
		respond_to do |format|
		  format.html { redirect_to orders_path, notice: 'Success.' }
		end
	end
  end
	  
end
