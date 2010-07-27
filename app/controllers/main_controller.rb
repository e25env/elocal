class MainController < ApplicationController
  require "open-uri"
  require "hpricot"

  def status
    @xmain= GmaXmain.find params[:id]
    @xvars= @xmain.xvars
#    flash.now[:notice]= "รายการ #{@xmain.id} ได้ถูกยกเลิกแล้ว" if @xmain.status=='X'
    flash.now[:notice]= "transaction #{@xmain.id} was cancelled" if @xmain.status=='X'
  rescue
    flash[:notice]= "could not find transaction id <b> #{params[:id]} </b>"
    redirect_to_root
  end
  def help
#    render :text => "help"
  end
  def index
    @news = News.all :limit => 5, :order => "created_at DESC"
    @xmains= GmaXmain.all :conditions=>"status='R' or status='I' ", :order=>"created_at"
  end
  def search
    if params[:q]
      @q = params[:q]
    else
      @q = params[:gma_search][:q]
      s= GmaSearch.new params[:gma_search]
      s.ip= request.env["REMOTE_ADDR"]
      s.save
    end
    count = Search.count :conditions => ["item LIKE ?", "%#{@q.downcase}%" ]
    gen_more_wwp(s) if count < ENOUGH_SEARCH
#    @waypoints = Waypoint.all :conditions => ["code LIKE ? OR LOWER(name) LIKE ?", "%#{wwp_code(params[:gma_search][:q])}%", "%#{params[:gma_search][:q].downcase}%" ]
    @searches = Search.search(@q.downcase, params[:page], 10)
  end
  def err404
    gma_log 'ERROR', 'main/err404'
    flash[:notice] = "We're sorry, but something went wrong. We've been notified about this issue and we'll take a look at it shortly."
    redirect_to root
  end
  def err500
    gma_log 'ERROR', 'main/err500'
    flash[:notice] = "We're sorry, but something went wrong. We've been notified about this issue and we'll take a look at it shortly."
    redirect_to root
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
end
