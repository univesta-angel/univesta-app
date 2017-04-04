class OrderController < ApplicationController
  def index
    shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current

    #@orders = ShopifyAPI::Order.find(:all, :params => {limit: 5, order: "created_at DESC"})   
    if request.xhr?
      
      if (params[:financial_status].present?) || (params[:fulfillment_status].present?) || (params[:order_status].present?) || (params[:start].present?) && (params[:end].present?)      
        fls = params[:fulfillment_status]
        fns = params[:financial_status]
        os = params[:order_status]  
        if (params.has_key?(:start) && params.has_key?(:end))
          start_ = params[:start]
          end_ = params[:end]
          @orders = ShopifyAPI::Order.find(:all, :params => { :financial_status => fns , :fulfillment_status => fls, :order_status => os, :created_at_min => start_, :created_at_max => end_ })
        else
          @orders = ShopifyAPI::Order.find(:all, :params => { :financial_status => fns , :fulfillment_status => fls, :order_status => os })
        end
        respond_to do |format|
          format.html { redirect_to orders_path }
          format.json { render json: @orders }
        end
      else
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
        respond_to do |format|
          format.html { redirect_to orders_path }
          format.json { render json: @orders }
        end
      end #end of if else statement params
      
    else
      
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
      
  end
  
  def from_category
    @orders = ShopifyAPI::Order.find(:all, :params => { :financial_status => "paid" })
    respond_to do |format|
      format.js
    end
  end
end
