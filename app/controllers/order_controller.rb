class OrderController < ApplicationController
  def index
    
    count = ShopifyAPI::Order.find(:count)
    pages = count % 250
    order = nil
    1.upto(pages) do |page|
      orders = ShopifyAPI::Order.find(:all, params: {limit: 250, page: page})
      order = orders.find { |o| o.order_number == DESIRED_NUMBER }
      break if order
    end
    
  end
end
