class OrderController < ApplicationController
  def index
    
    
    count = ShopifyAPI::Order.find(:count)
    pages = count % 250
    order = nil
    1.upto(pages) do |page|
      @orders = ShopifyAPI::Order.find(:all, params: {limit: 250, page: page})
    end
    
  end
end
