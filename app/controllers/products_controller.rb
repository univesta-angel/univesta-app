class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  wrap_parameters format: [:json]

  #wrap_parameters format: [:json]
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
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
    @product = Product.create(title: params[:prodt],
                              body_html: params[:body_html],
                              product_type: params[:product_type],
                              images: params[:images],
                              vendor: params[:vendor],
                              price: params[:price])

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
    shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current
    #@product = Product.find(product_params)
    #@product = ShopifyAPI::Product.create(product_params)

    images = []
    image = {}
    image["src"] = params[:_img]

    images << image

    new_product = ShopifyAPI::Product.new
    new_product.title = params[:_title]
    new_product.body_html = params[:_body]
    new_product.product_type = params[:_type]
    new_product.vendor = params[:_vendor]
    new_product.images = images
    new_product.tags = params[:_tags]
    new_product.variants = [ShopifyAPI::Variant.new(
      :option1              => "Large",
      :price                => params[:_price],
      #:barcode              => "1234_barcode",
      :sku                  => params[:_sku],
      #:taxable              => true,
      #:weight               => 100,
      #:weight_unit          => "kg"
      :inventory_management => 'shopify',
      :inventory_quantity   => 10,
    )]
    new_product.save

    #new_product = ShopifyAPI::Product.create({ :body_html => "Test description", :title => "Test Product" })
    
    expires_in(60.seconds, public: false)


    redirect_back(fallback_location: root_path)

    respond_to do |format|
      if @product.save
        redirect_back(fallback_location: root_path)
      else
        redirect_back(fallback_location: root_path)
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