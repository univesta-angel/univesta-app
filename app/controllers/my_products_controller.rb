class MyProductsController < ApplicationController
  before_action :set_my_product, only: [:destroy]
  def index
    products = ShopifyAPI::Product.find(:all)
    @myproducts = []
    products.each do |product|
      product.metafields.each do |metafield|
        m_namespace = metafield.namespace
      end
      if m_namespace == 'imported-item'
        @myproducts << product
      end
    end
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
