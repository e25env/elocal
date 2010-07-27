# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :wwp_code, :dm, :dms, :valid_google_ad_script?
  # protect_from_forgery # See ActionController::RequestForgeryProtection for details
  geocode_ip_address

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password


  private
  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end

  helper_method :mobile_device?

end
