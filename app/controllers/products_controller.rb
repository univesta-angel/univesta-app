class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  wrap_parameters format: [:json]

  #wrap_parameters format: [:json]
  # GET /products
  # GET /products.json
  def index
    #@products = Product.all

    @products = Product.search(params[:search])
    @angel = 1;
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.create(title: params[:title],
                              body_html: params[:body_html],
                              product_type: params[:product_type],
                              images: params[:images],
                              vendor: params[:vendor],
                              tags: params[:tags],
                              price: params[:price],
                              compare_at_price: params[:compare_at_price],
                              colors: params[:colors],
                              sizes: params[:sizes],
                              avail_qty: params[:avail_qty],
                              variant_images: params[:variant_images])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully imported.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # push to store action
  def push
    require "net/http"
    require "uri"
    #shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc 392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"

    data = {
      "product": {
        "title": "Burton Custom Freestyle 151",
        "body_html": "<strong>Good snowboard!<\/strong>",
        "vendor": "Burton",
        "product_type": "Snowboard"
      }
    }

    uri = URI('https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc 392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin/products.json')
      
      req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      req.body = data
      res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(req)
      end



  end












  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :body_html, :images, :product_type, :tags, :vendor)
    end


end