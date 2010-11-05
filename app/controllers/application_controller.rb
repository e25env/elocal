class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :fiscal_year, :finance_office?, :office_office?,
    :own_xmain?, :mobile_device?

  # protect_from_forgery # See ActionController::RequestForgeryProtection for details
  #
  # geocode_ip_address

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def finance_office?
    current_user.role && current_user.role.upcase.split(',').include?('CO') && current_user.section_id==2
  end
  def office_office?
    current_user.role && current_user.role.upcase.split(',').include?('CO') && current_user.section_id==1
  end
#----------------------

  def login_laas
    ff=FireWatir::Firefox.new :waitTime=>4
    ff.goto('http://www.laas.go.th/')
    ff.text_field(:id,"_ctl0_txtUserName").set(LAAS_USER)
    ff.text_field(:id,"_ctl0_txtPassword").set(LAAS_PASSWORD)
    ff.button(:name,"_ctl0:btnLogin").click
    ff
  end
  def own_xmain?
    if $xvars
      return current_user.id==$xvars[:user_id]
    else
      return true
    end
  end
  def fiscal_year(t=Time.now)
    if (10..12).include? t.month
      return t.year+544
    else
      return t.year+543
    end
  end
  
  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end


end
