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
	  	markup = Markup.find(2) 
	  	markup.price = params[:pmu].to_f
	  	markup.compare_at_price = params[:capmu].to_f
	  	markup.operator1 = params[:p_operator]
	  	markup.operator2 = params[:c_operator]
	  	markup.cap_toggle = params[:c_toggle].to_s
	  	markup.save

      products = ShopifyAPI::Product.all

      variants = ShopifyAPP::Variant.all
      variants.each do |v|
        v.price = v.price + markup.price.to_f
        v.compare_at_price + markup.compare_at_price.to_f
      end
      variants.save

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
