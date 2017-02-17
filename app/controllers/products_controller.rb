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
    @ctr = 1
    @ctr2 = 0
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
                              images: params[:images],  #array
                              vendor: params[:vendor],
                              tags: params[:tags],
                              price: params[:price], #array
                              compare_at_price: params[:compare_at_price], #array
                              colors: params[:colors],  #array
                              sizes: params[:sizes],  #array
                              avail_qty: params[:avail_qty],  #array
                              variant_images: params[:variant_images])  #array

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

    options = []
    #option = {}
    option = ShopifyAPI::Option.new(:name => "Color")
    options << option
    option1 = ShopifyAPI::Option.new(:name => "Size")
    options << option1

    color = params[:_colors].split
    colorz = params[:_colors].split
    size = params[:_sizes].split
    prices = params[:_prices].split
    compAtPrice = params[:_compare_at_price].split
    qty = params[:_avail_qty].split
    variant_img = params[:_variant_images].split
    default_img = params[:_img].split
    
    images = []
    default_img.each do |img|
      image = {}
      image["src"] = img
      images << image
    end
    
    if color.size==0
      color=['-']
    end
    if size.size==0
      size=['-']
    end
    
    i = 0;
    variants = []
    color.each do |row1|
      str = row1.gsub!(/_/, ' ')
      size.each do |row2|
        str2 = row2.gsub!(/_/, ' ')
        zzz = ShopifyAPI::Variant.new( 
          :price                => prices[i],
          :option1              => row1, 
          :option2              => row2,   
          :compare_at_price     => compAtPrice[i],
          :sku                  => params[:_sku],
          :inventory_management => 'shopify',
          :inventory_quantity   => qty[i]
        )
        variants << zzz
        i = i + 1;
      end
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

    if colorz.size==0
     color.each do |row1|
        color2=[]
        size.each do |row2|
          color2 << new_product.variants[ctr].id
          ctr = ctr + 1
        end
        pao << { id: nil, variant_ids: color2, src: default_img[0] }
        aaa = aaa + 1
      end
    else
      color.each do |row1|
        color2=[]
        size.each do |row2|
          color2 << new_product.variants[ctr].id
          ctr = ctr + 1
        end
        pao << { id: nil, variant_ids: color2, src: variant_img[aaa] }
        aaa = aaa + 1
      end
    end
    
    new_product.images = pao 
    new_product.save
  
    expires_in(60.seconds, public: false)

    respond_to do |format|
      if new_product.save
        format.html { redirect_to root_path, notice: 'Product was successfully pushed.' }
        format.json { render json: 201 }
      else
        format.html { redirect_to root_path, notice: 'Oops. Something went wrong.' }
        format.json { render json: new_product.errors, status: :unprocessable_entity }
      end
    end
  end
  
  #------------------------------------------------------------------------------------------------------------------------
  
  def push_all
    Product.all.each do |p|
      
      shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
      ShopifyAPI::Base.site = shop_url
      shop = ShopifyAPI::Shop.current

      options = []
      #option = {}
      option = ShopifyAPI::Option.new(:name => "Color")
      options << option
      option1 = ShopifyAPI::Option.new(:name => "Size")
      options << option1

      color = p.colors.split
      colorz = p.colors.split
      size = p.sizes.split
      prices = p.prices.split
      compAtPrice = p.compare_at_price.split
      qty = p.avail_qty.split
      variant_img = p.variant_images.split
      default_img = p.images.split

      images = []
      default_img.each do |img|
        image = {}
        image["src"] = img
        images << image
      end

      if color.size==0
        color=['-']
      end
      if size.size==0
        size=['-']
      end

      i = 0;
      variants = []
      color.each do |row1|
        str = row1.gsub!(/_/, ' ')
        size.each do |row2|
          str2 = row2.gsub!(/_/, ' ')
          zzz = ShopifyAPI::Variant.new( 
            :price                => prices[i],
            :option1              => row1, 
            :option2              => row2,   
            :compare_at_price     => compAtPrice[i],
            :sku                  => params[:_sku],
            :inventory_management => 'shopify',
            :inventory_quantity   => qty[i]
          )
          variants << zzz
          i = i + 1;
        end
      end
      
      products = ShopifyAPI::Product.new
      
      products = ShopifyAPI::Product.new
      products.title = p.title
      products.body_html = p.body_html
      products.product_type = p.product_type
      products.vendor = p.vendor
      products.tags = p.tags
      products.options = options
      products.variants = variants
      products.save
    
      pao = []
      color2 =[]     #tempo storage
      aaa = 0 
      ctr = 0 

      if colorz.size==0
       color.each do |row1|
          color2=[]
          size.each do |row2|
            color2 << new_product.variants[ctr].id
            ctr = ctr + 1
          end
          pao << { id: nil, variant_ids: color2, src: default_img[0] }
          aaa = aaa + 1
        end
      else
        color.each do |row1|
          color2=[]
          size.each do |row2|
            color2 << new_product.variants[ctr].id
            ctr = ctr + 1
          end
          pao << { id: nil, variant_ids: color2, src: variant_img[aaa] }
          aaa = aaa + 1
        end
      end

      products.images = pao 
      products.save
      
    end
  
    expires_in(60.seconds, public: false)

    respond_to do |format|
      if new_product.save
        format.html { redirect_to root_path, notice: 'All product was successfully pushed.' }
        format.json { render json: 201 }
      else
        format.html { redirect_to root_path, notice: 'Oops. Something went wrong.' }
        format.json { render json: new_product.errors, status: :unprocessable_entity }
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
  
  def select_action
    if params[:commit] == "Remove selected"
      Product.destroy(params[:product_ids])
      
    elsif params[:commit] == "Push selected"
      Product.find(params[:product_ids]).each do |p|
        
        #create product api
        
        p.destroy
      end
    end

    respond_to do |format|
     format.html { redirect_to zzzs_path, notice: "Success." }
     format.json { head :no_content }
    end
  end
  
  def destroy_all_items
    Product.delete_all

    respond_to do |format|
     format.html { redirect_to root_path, notice: 'All import products were deleted.' }
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
