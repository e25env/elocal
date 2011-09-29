class MainController < ApplicationController
  # require "open-uri"
  # require "hpricot"

  def home
    if login?
      @xmains= GmaXmain.all :conditions=>"status='R' or status='I' ", :order=>"created_at", :include=>:gma_runseqs
    end
    render :layout => false 
  end
  def index
    # update_intranet_ip
    # if params[:module]
    #   session[:module]= params[:module]
    #   redirect_to :controller=>params[:module]
    # else
    #   redirect_to :action => "pending"
    # end
      redirect_to :action => "home"
  end
  def about
    render :layout => false 
  end
  def store_asset
    if params[:content]
      doc = GmaDoc.create! :name=> 'asset',
        :filename=> (params[:file_name]||''),
        :content_type => (params[:content_type] || 'application/zip'),
        :data_text=> '',
        :display=>true 
      path = (IMAGE_LOCATION || "tmp")
      File.open("#{path}/f#{doc.id}","wb") { |f|
        f.puts(params[:content])
      }
      render :xml=>"<elocal><doc id='#{doc.id}' /><success /></elocal>"
    else
      render :xml=>"<elocal><fail /></elocal>"
    end
  end
  def status
    @xmain= GmaXmain.find params[:id]
    @title= "สถานะการดำเนินงานเลขที่ #{params[:id]} #{@xmain.name}"
    @backbtn= true
    @xvars= @xmain.xvars
    flash.now[:notice]= "รายการ #{@xmain.id} ได้ถูกยกเลิกแล้ว" if @xmain.status=='X'
    # flash.now[:notice]= "transaction #{@xmain.id} was cancelled" if @xmain.status=='X'
  rescue
    flash[:notice]= "ขออภัย ไม่สามารถค้นหางานเลขที่ <b> #{params[:id]} </b>"
    redirect_to_root
  end
  def help
#    render :text => "help"
  end
  def pending
    @xmains= GmaXmain.all :conditions=>"status='R' or status='I' ", :order=>"created_at", :include=>:gma_runseqs
  end
  def search
    @q = params[:q] || params[:gma_search][:q] || ""
    @title = "ผลการค้นหา #{@q}"
    @backbtn= true
    @cache= true
    if @q.blank?
      redirect_to "/"
    else
      s= GmaSearch.create :q=>@q, :ip=> request.env["REMOTE_ADDR"]
      do_search
    end
  end
  def do_search
    if current_user.secured?
      @docs = GmaDoc.search_secured(@q.downcase, params[:page], PER_PAGE)
    else
      @docs = GmaDoc.search(@q.downcase, params[:page], PER_PAGE)
    end
    @xmains = GmaXmain.find @docs.map(&:gma_xmain_id)
  end
  def err404
    gma_log 'ERROR', 'main/err404'
    flash[:notice] = "We're sorry, but something went wrong. We've been notified about this issue and we'll take a look at it shortly."
    redirect_to '/'
  end
  def err500
    gma_log 'ERROR', 'main/err500'
    flash[:notice] = "We're sorry, but something went wrong. We've been notified about this issue and we'll take a look at it shortly."
    redirect_to '/'
  end

  # ajax call to update modules menu and sidebar
  def modules
    @modules= GmaModule.all :order=>"seq"
    render :layout => false
  end
  def sidebar
    @gma_module= GmaModule.find_by_name params[:module]
    @waypoint= Waypoint.find session[:waypoint_id]
    render :layout => false
  end
  def person
    @people= Person.find :all, :conditions=>['nid LIKE ?', "#{params[:term]}%"], :limit=>10
    @select= @people.map {|p| {:label=>p.label, :value => p.nid } }
    render :json=>@select
  end
  def address
    @addresses= Address.find :all, :conditions=>['code LIKE ?', "#{params[:term]}%"], :limit=>10
    @select= @addresses.map {|p| {:label=>"#{p.code}:#{p.name}:#{p.id}", :value => p.code }}
    render :json=>@select
  end
  def get_person_address
    person= Person.find params[:id]
    render :json=>person.address
  end
  def get_districts
    province= Province.find params[:id]
    prompt= "<option value="">..กรุณาเลือกอำเภอ</option>"
    render :text => prompt+@template.options_from_collection_for_select(province.districts,:id,:name)
  end
  def get_sub_districts
    district= District.find params[:id]
    render :text => @template.options_from_collection_for_select(district.sub_districts,:id,:name)
  end
end
