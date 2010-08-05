# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :fiscal_year, :finance_office?
  # protect_from_forgery # See ActionController::RequestForgeryProtection for details
#  geocode_ip_address

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def finance_office?
    current_user.role && current_user.role.upcase.split(',').include?('CO') && current_user.section_id==2
  end
  def fiscal_year(t=Time.now)
    if (10..12).include? t.month
      return t.year+544
    else
      return t.year+543
    end
  end
  private
  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end

  helper_method :mobile_device?

end
