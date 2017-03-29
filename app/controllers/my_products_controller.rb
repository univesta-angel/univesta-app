class MyProductsController < ApplicationController
  def index
    @myproducts = ShopifyAPI::Product.find(:all)
  end
  
  def delete_my_product
    ShopifyAPI::Product.delete(:prd_id)
    respond_to do |format|
      format.html { redirect_to my_products_path, notice: 'Product was successfully deleted.' }
    end
  end
end
