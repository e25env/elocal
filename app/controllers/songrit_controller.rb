class SongritController < ApplicationController
  include ActionView::Helpers::DebugHelper
  include ERB::Util
  require "csv"
  require "hpricot"
  require "open-uri"
  require 'nokogiri'
  require 'mechanize'

  # set up new lao
  def set_up
    # create anonymous user
    # create org
    # view 'update User class methods'
  end

  def add_code_laas
    Cat.all.each do |r|
      r.code_laas= r.code
      r.save
    end
    Ptype.all.each do |r|
      r.code_laas= r.code
      r.save
    end
    Plan.all.each do |r|
      r.code_laas= r.code
      r.save
    end
    Task.all.each do |r|
      r.code_laas= r.code
      r.save
    end
    render :text=>"done"
  end
  def test_laas
    ff=FireWatir::Firefox.new :waitTime=>4
    ff.goto('http://www.laas.go.th/')
    ff.text_field(:id,"_ctl0_txtUserName").set("abtbtnai714")
    ff.text_field(:id,"_ctl0_txtPassword").set("318883")
    ff.button(:name,"_ctl0:btnLogin").click
    ff.goto('http://www.laas.go.th/Default.aspx?menu=514EE166-B162-412E-9A68-0B1C866DE50E&control=list')
    ff.button(:name,'_ctl0:_ctl0:btnAdd').click # สร้างโครงการ
    doc = Nokogiri::HTML(ff.html)
    plans = doc.at_css('select')
    # get plans
    plans.css('option').each do |p|
      next if p['value'].blank?
      plan = Plan.create :name=>p['title'], :code=>p['value'],
        :fy=>2553, :balance=>0, :budget=>0
    end
    # get tasks
    Plan.all.each do |p|
      url = "http://www.laas.go.th/DropDownService.asmx/GetExpExpenseJob?PlanID=#{p.code}"
      doc = Nokogiri::XML(open(url))
      doc.search('DropdownData').each do |t|
        next if t.search('Value').text.blank?
        Task.create :plan_id=>p.id, :name=>t.search('Text').text,
          :code=>t.search('Value').text, :budget=>0, :balance=>0,
          :fy=>2553
      end
    end
    # get cats
    cats= doc.at_css('#_ctl0__ctl0_usrPrjMGTForm_FbddlCategory_ddlMain')
    cats.css('option').each do |p|
      next if p['value'].blank?
      cat = Cat.create :name=>p.text, :code=>p['value'],
        :fy=>2553, :balance=>0, :budget=>0
    end
    # get ptypes
    Cat.all.each do |p|
      url = "http://www.laas.go.th/DropDownService.asmx/GetExpExpenseType?categoryID=#{p.code}"
      doc = Nokogiri::XML(open(url))
      doc.search('DropdownData').each do |t|
        next if t.search('Value').text.blank?
        Ptype.create :cat_id=>p.id, :name=>t.search('Text').text,
          :code=>t.search('Value').text, :budget=>0, :balance=>0,
          :fy=>2553
      end
    end

    ff.close
    render :text => 'hello'
  end
  def test_search
    q= 'พรชัย'
    @docs = GmaDoc.all :conditions =>
      ["content_type=? AND data_text LIKE ?", "output", "%#{q}%" ],
      :order=>'gma_xmain_id DESC', :select=>'DISTINCT gma_xmain_id'
    @xmains = GmaXmain.find @docs.map(&:gma_xmain_id)
    render :text => debug(@xmains)
  end
  def test_timeout
    render :layout=>false
  end
  def test_document
#    path = defined?(IMAGE_LOCATION) ? IMAGE_LOCATION : "tmp"
    if GmaDoc.exists?(params[:id])
      doc = GmaDoc.find params[:id]
      if %w(output temp).include?(doc.content_type)
        render :text=>doc.data_text
      else
#        data= read_binary("#{path}/f#{params[:id]}")
#        send_data(data, :filename=>doc.filename, :type=>doc.content_type, :disposition=>"inline")
        send_data(Upload.find(doc.data_text).content.to_s, :filename=>doc.filename, :type=>doc.content_type, :disposition=>"inline")
      end
    else
      data= read_binary("public/images/file_not_found.jpg")
      send_data(data, :filename=>"img_not_found.png", :type=>"image/png", :disposition=>"inline")
    end
  end

  def test_mongo
    u = Upload.create :content=>'hello'
    render :text => debug(u)
  end
  def a2waypoint(s='hello *songrit, how are you?')
    render :text => s.gsub!(/\*([\w]+)(\W)?/, '<a href="/\1">*\1</a>\2')
  end
  def test_user_agent
    render :text => request.user_agent
  end
  def test_rmagick
    img_orig = Magick::Image.read("tmp/f6").first
#    img = img_orig.matte_floodfill("white")
    img_orig.write("tmp/f0.gif")
    render :text => "done"
  end
  def test_pic
    xmain = GmaXmain.find 24
    @xvars = xmain.xvars
    doc = GmaDoc.find @xvars[:add][:waypoint_pic_doc_id]
    from = "tmp/f#{@xvars[:add][:waypoint_pic_doc_id]}"
    to = "tmp/#{doc.filename}"
    FileUtils.cp from, to
    url = postimg(to)
    render :text => url
  end
  def test_const
    a= defined?(IMAGE_LOCATION) ? "has" : "undefined"
    render :text => a
  end
  def test_postimg
    p = postimg("/media/DATA/pictures/2print/IMAG0742.jpg")
    render :text => "<a href='#{p}'>#{p}</a>"
  end
end

