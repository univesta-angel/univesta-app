class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  wrap_parameters format: [:json]

  #wrap_parameters format: [:json]
  # GET /products
  # GET /products.json
  def index
    #@products = Product.all

    @products = Product.search(params[:search])
    #@collects = ShopifyAPI::Collect.find(:all)    #get collection
    @bulkaction = ["Push Selected", "Remove Selected"]
    @ctr = 1
  end
  
  # order lists
  def order
   # @orders = ShopifAPI::Order.find(:all)
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
                              price2: params[:price2],
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
  
  def bulkaction
    
  end
   
  def edit_price
    new_val = '%.2f' % params[:new_val]
    new_value = new_val.to_s
    new_prices = []
    Product.find(params[:productid]) do |product|
      product.price2.each do |price|
        new_prices << new_value
      end
    end
    Product.update(params[:productid], :price2 => new_prices)
  end

  def edit_cap
    new_val = '%.2f' % params[:new_val]
    new_value = new_val.to_s
    new_prices = []
    Product.find(params[:productid]) do |product|
      product.compare_at_price.each do |price|
        new_prices << new_value
      end
    end
    Product.update(params[:productid], :compare_at_price => new_prices)
  end
  
  def multiply_price
    multiplier = params[:new_val].to_f
    new_prices = []
    aaa = params[:productid];
    
    Product.all.each do |product|
        if product.id==aaa.to_i
          product.price.each do |price|
            prc = price.to_f * multiplier
            new_prices << prc
          end
        end
    end
    Product.update(params[:productid], :price2 => new_prices)
    respond_to do |format|
      format.html 
      format.js
    end
  end

  def multiply_cap
    multiplier = params[:new_val].to_f
    new_prices = []
    aaa = params[:productid];
    Product.all.each do |product|
        if product.id==aaa.to_i
          product.price.each do |price|
            prc = price.to_f * multiplier
            new_prices << prc
          end
        end
    end
    Product.update(params[:productid], :compare_at_price => new_prices)
    respond_to do |format|
      format.html
      format.js
    end

  end
  
  # push to store action
  def push
    shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current
   
    options = []
    option = ShopifyAPI::Option.new(:name => "Color")
    options << option
    option1 = ShopifyAPI::Option.new(:name => "Size")
    options << option1
    
    variantsid = params[:check_var]
    _color = params[:_color]
    _size = params[:_size]
    _sku = params[:_sku]
    _prc = params[:_prc2]
    _cap = params[:_compAtPrice]
    _qty = params[:_qty]
    
    variants = []
    variantsid.each do |variant|
      zzz = ShopifyAPI::Variant.new( 
        :price                => _prc[variant.to_i],
        :option1              => _color[variant.to_i].gsub('_', ' '),
        :option2              => _size[variant.to_i].gsub('_', ' '),   
        :compare_at_price     => _cap[variant.to_i],
        :sku                  => _sku[variant.to_i],
        :inventory_management => "shopify",
        :inventory_quantity   => _qty[variant.to_i]
      )
      variants << zzz
    end
    
    new_product = ShopifyAPI::Product.new
    new_product.title = params[:_title]
    new_product.body_html = params[:_body]
    new_product.product_type = params[:_type]
    new_product.vendor = params[:_vendor]
    new_product.tags = params[:_tags]
    new_product.options = options
    new_product.variants = variants
    new_product.save
    
    pao = []
    color2 =[]     #tempo storage
    aaa = 0 
    ctr = 0 
    
    _varimg = params[:_varimg]
    
    if _color.size==0
      variantsid.each do |row|
        color2 = []
        color2 << new_product.variants[ctr].id
        ctr = ctr + 1
      end
      pao << { id: nil, variant_ids: color2, src: default_img[0] }
    else
      gel = ''
      color2 = []
      variantsid.each do |row|
        if gel==''
          gel = _varimg[row.to_i]
          color2 << new_product.variants[row.to_i].id
             
        elsif gel!=_varimg[row.to_i]
          pao << { id: nil, variant_ids: color2, src: _varimg[lastrow] }
          gel = _varimg[row.to_i]
          color2 = []
          color2 << new_product.variants[row.to_i].id
       else
          color2 << new_product.variants[row.to_i].id
        end
        
    
    #color2 << new_product.variants[ctr].id
        lastrow = row.to_i
      end
      pao << { id: nil, variant_ids: color2, src: _varimg[lastrow] }
      
    end
    
    new_product.images = pao 
    new_product.save
    
    respond_to do |format|
      format.html { redirect_to imports_path, notice: 'Product was successfully pushed.' }
    end
    
  end
  
  def remove_all
    Product.delete_all

    respond_to do |format|
      format.html { redirect_to imports_path, notice: 'All imports were deleted.' }
    end
  end
  
  def push_all
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
