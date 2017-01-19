class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  #wrap_parameters format: [:json]
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
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
                              images: params[:images],
                              product_type: params[:product_type],
                              tags: params[:tags],
                              vendor: params[:vendor])

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
    shop_url = "https://4d60f4fb9986af453d74b9bee9369fd1:000a1b69647c053726bbdd82b103a83d@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    ShopifyAPI::Session.setup({:api_key => "345caeafea49d80e0f40194dd9a721c5", :secret => "43f67e64209c57cb6ba9116a9a79be9d"})
    session = ShopifyAPI::Session.new("gels-store.myshopify.com")
    scope = ["write_products"]
    permission_url = session.create_permission_url(scope, "https://shopifyapp-sample.herokuapp.com/auth/shopify/callback")
    ShopifyAPI::Base.activate_session(session)
    #@product = Product.find(product_params)
    #@product = ShopifyAPI::Product.create(product_params)
    new_product = ShopifyAPI::Product.create("title": "Sample Product")
    #new_product = ShopifyAPI::Product.create({ :body_html => "Test description", :title => "Test Product" })

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully pushed to store.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
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