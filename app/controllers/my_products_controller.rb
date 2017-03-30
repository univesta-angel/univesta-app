class MyProductsController < ApplicationController
  def index
    @myproducts = ShopifyAPI::Product.find(:all)
  end
  
  def delete_my_product
    ShopifyAPI::Product.delete(:prd_id)
  end
end
