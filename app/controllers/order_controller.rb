class OrderController < ApplicationController
  def index
    shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current

    @orders = ShopifyAPI::Order.find(:all, :params => { :order => "created_at DESC" })   
    
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
	if params[:note].present? && params[:order_id].present?
		shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
		ShopifyAPI::Base.site = shop_url
		shop = ShopifyAPI::Shop.current

		orderid = params[:order_id]		
		order = ShopifyAPI::Order.find(orderid)
		#tracking_no = params[:tracking_no]
		#order = ShopifyAPI::Order.find(:first, :params => { :id => 4537069840 })
		#f = ShopifyAPI::Fulfillment.new(:order_id => order.id, :notify_customer => false ,:tracking_number => nil, :line_items =>[ {"id" => order.line_items.first.id} ])
		#f = ShopifyAPI::Fulfillment.new(order_id: order.id, line_items: [ { id: order.line_items.first.id} ] )
		#f.prefix_options = { :order_id => order.id }
		#f.save
		#shipment_info = { order_id: order.id, notify_customer: false, line_items: [{id: order.line_items.first.id}] }
		#f = ShopifyAPI::Fulfillment.create(shipment_info)  
		order.line_items.map(&:id).each do |li_id|
		  attrs = { "notify_customer": false, "line_items": [{"id": li_id}], "status": "success", }
		  api.post("/admin/orders/#{order.id}/fulfillments.json", { "fulfillment": attrs })
		end
		
		respond_to do |format|
		  format.html { redirect_to orders_path, notice: 'Success.' }
		end
	end
  end
	  
end
