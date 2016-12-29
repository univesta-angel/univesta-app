class HomeController < ShopifyApp::AuthenticatedController
  def index
  	
    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    @import = Import.new(import_params)

    respond_to do |format|
      if @import.save
        format.html { redirect_to @import, notice: 'Import was successfully created.' }
        format.json { render :show, status: :created, location: @import }
      else
        format.html { render :new }
        format.json { render json: @import.errors, status: :unprocessable_entity }
      end
    end

  end
end
