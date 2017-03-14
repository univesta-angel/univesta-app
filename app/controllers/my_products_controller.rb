class MyProductsController < ApplicationController
  def index
    @myproducts = ShopifyAPI::Product.find(:all)
  end
end
