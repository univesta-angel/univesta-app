class SettingsController < ApplicationController
  helper_method :string_checker
  def index
  	@markup = Markup.find(2)
  	@captoggle = @markup.cap_toggle
  	@price_fm = string_checker(@markup.operator1)
  	@cap_fm = string_checker(@markup.operator2)

  end
  
  def global_pricing
  	@abc = 12345
  end

  def edit_markup
    shop_url = "https://77d56bcf8d3ab9647b85d9030f2b1e1b:22c7a88a600583dea6c121fcb9eb1daf@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current
  	markup = Markup.find(2) 
  	markup.price = params[:pmu].to_f
  	markup.compare_at_price = params[:capmu].to_f
  	markup.operator1 = params[:p_operator]
  	markup.operator2 = params[:c_operator]
  	markup.cap_toggle = params[:c_toggle].to_s
  	markup.save

    products = ShopifyAPI::Product.all
    products.each do |product|
      if !product.metafields.blank?
        product.metafields.each do |metafield|
          namespace = metafield.namespace
          if namespace == "imported-item"
            product.variants.each do |v|
              v.price = v.price.to_f + markup.price
              v.compare_at_price = v.compare_at_price.to_f + markup.compare_at_price
            end
          end
        end
      end
    end

    products.save

		render js: 'window.location.reload'
  end

  def markup
    markup = Markup.find(2)

    data = { :markup => markup.price }.to_json
    respond_to do |format|
      format.json { render :json => data }
    end
  end

  def string_checker(strvar)
  	markup = ''
  	if strvar == '+'
  		markup = 'Fixed'
  	else
  		markup = 'Multiplier'
  	end
	return markup
  end

end
