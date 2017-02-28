class MyProductsController < ApplicationController
  def index
    ShopifyAPI::Base.activate_session(session[:shopify])
    @myproducts = ShopifyAPI::Product.find(:all)
  end
end
