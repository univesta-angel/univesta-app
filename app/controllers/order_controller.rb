class OrderController < ApplicationController
  def index
  	@orders = ShopifyAPI::Order.all
  end
end
