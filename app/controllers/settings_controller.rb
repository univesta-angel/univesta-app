class SettingsController < ApplicationController
  helper_method :string_checker
  def index
  	@markup = Markup.find(2)
  	@captoggle = @markup.cap_toggle
  	@price_fm = string_checker(@markup.operator)
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
	  	markup.capToggle = params[:c_toggle].to_s
	  	markup.save

  		render js: 'window.location.reload'
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
