class MyProductsController < ApplicationController
  before_action :set_my_product, only: [:destroy]
  def index
    @myproducts = ShopifyAPI::Product.find(:all)
  end
  
  def destroy
    @my_product.destroy
    respond_to do |format|
      format.html { redirect_to my_products_url, notice: 'My product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_product
      @my_product = ShopifyAPI::Product.find(params[:id])
    end
end
