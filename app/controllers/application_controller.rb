class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_filter :allow_ajax_request_from_other_domains

  def allow_ajax_request_from_other_domains
   headers['Access-Control-Allow-Origin'] = '*'
   headers['Access-Control-Request-Method'] = '*'
   headers['Access-Control-Allow-Headers'] = '*'
 end
 
end
