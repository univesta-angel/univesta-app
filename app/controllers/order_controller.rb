class OrderController < ApplicationController
  def index
    shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current

    #@orders = ShopifyAPI::Order.find(:all, :params => {limit: 5, order: "created_at DESC"})
    if (params[:start].present?) && (params[:end].present?)
      @orders = ShopifyAPI::Order.find(:all, :params => { :created_at_min => params[:start], :created_at_max => params[:end] })
    elsif (params[:financial_status].present?) || (params[:fulfillment_status.present?) || (params[:order_status].present?)
        fls = params[:fulfillment_status]
        fns = params[:financial_status]
        os = params[:order_status]
        @orders = ShopifyAPI::Order.find(:all, :params => { :financial_status => fns , :fulfillment_status => fls, :order_status => os })
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
       
    end #end of if else statement
      
  end
end
