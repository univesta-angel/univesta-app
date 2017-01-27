class MyProductsController < ApplicationController
  def index
    @products = ShopifyAPI::Product.find(:all)
  end
end
