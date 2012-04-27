class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :fiscal_year, :finance_office?, :office_office?,
    :own_xmain?, :mobile_device?, :atype, :b, :end_of_last_month,
    :begin_of_last_month, :begin_of_fiscal_year, :process_services,
    :process_roles

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
  def process_services(app)
    @services= app.elements["//node[@TEXT='services']"] || REXML::Document.new
    md5= Digest::MD5.hexdigest(@services.to_s)
    return if (session[:services_md5] && (session[:services_md5]==md5))
    session[:services_md5] = md5
    protected_services = []
    protected_modules = []
    mseq= 0
    @services= app.elements["//node[@TEXT='services']"] || REXML::Document.new
    @services.each_element('node') do |m|
      ss= m.attributes["TEXT"]
      code, name= ss.split(':', 2)
      next if code.blank?
      next if code.comment?
      module_code= name2code(code)
      # create or update to GmaModule
      gma_module= GmaModule.find_or_create_by_code module_code
      protected_modules << gma_module.id
      name = module_code if name.blank?
      gma_module.update_attributes :name=> name.strip, :seq=> mseq
      mseq += 1
      seq= 0
      m.each_element('node') do |s|
        service_name= s.attributes["TEXT"].to_s
        # t << "= #{module_code}::#{service_name}"
        scode, sname= service_name.split(':', 2)
        sname ||= scode; sname.strip!
        scode= name2code(scode)
        if scode=="role"
          gma_module.update_attribute :role, sname
          next
        end
        if scode.downcase=="link"
          role= get_option_xml("role", s) || ""
          rule= get_option_xml("rule", s) || ""
          gma_service= GmaService.find_or_create_by_module_and_code_and_name module_code, scode, sname
          gma_service.update_attributes :xml=>s.to_s, :name=>sname,
            :listed=>listed(s), :secured=>secured?(s),
            :gma_module_id=>gma_module.id, :seq => seq,
            :role => role, :rule => rule
          seq += 1
          protected_services << gma_service.id
        else
          # normal service
          step1 = s.elements['node']
          role= get_option_xml("role", step1) || ""
          rule= get_option_xml("rule", step1) || ""
          gma_service= GmaService.find_or_create_by_module_and_code module_code, scode
          gma_service.update_attributes :xml=>s.to_s, :name=>sname,
            :listed=>listed(s), :secured=>secured?(s),
            :gma_module_id=>gma_module.id, :seq => seq,
            :role => role, :rule => rule
          seq += 1
          protected_services << gma_service.id
        end
      end
    end
    GmaService.delete_all(["id NOT IN (?)",protected_services])
    GmaModule.delete_all(["id NOT IN (?)",protected_modules])
    # t.join("<br/>")
  end
  def process_roles(app)
    # t = ["process_roles"]
    # @app= get_app
    GmaRole.delete_all
    roles= app.elements["//node[@TEXT='roles']"] || REXML::Document.new
    roles.each_element('node') do |role|
      text= role.attributes['TEXT']
      c,n = text.split(': ')
      next if c.comment?
      GmaRole.create :code=>c.upcase, :name=>n, :gma_user_id=>get_user
      # t << "= #{text}"
    end
    # t.join("<br/>")
  end
  def update_intranet_ip
    www= songrit(:www)+"/ws/intranet_ping"
    RestClient.post www, :ip=>local_ip unless www.empty?
  rescue
  end
  def ws_dispatch
    GmaWsQueue.active.each do |q|
      begin
        RestClient.post(q.url, q.body)
        q.update_attribute :status, 1
      rescue Exception=>e
        logger.debug "ws_dispatch fail at #{Time.now}: #{e.message}"
      end
    end
  end
  def atype(a)
    ACCOUNT_TYPE[a-1]
  end
  def end_of_last_month
    d= Date.today
    dd= Date.new d.year, d.month, 1
    dd-1
  end
  def begin_of_last_month
    d= Date.today
    if d.month==1
      m = 12
      y = d.year-1
    else
      m = d.month-1
      y = d.year
    end
    dd= Date.new y, m, 1
  end
  def begin_of_fiscal_year
    d= Date.today
    year = d.month<10 ? d.year-1 : d.year
    dd= Date.new year, 10, 1
  end
  def b(s)
    (!s||s.to_s.empty?) ? "<b> - </b>" : "<b>#{s}</b>"
  end
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
