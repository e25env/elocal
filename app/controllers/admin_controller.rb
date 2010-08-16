class AdminController < ApplicationController
  before_filter :admin_action, :except=>[:daily_housekeeping, :hourly_housekeeping]

  def git_pull
    @t = "<b>git pull</b><br/>"
    @t = exec_cmd("git pull").gsub("\n","<br/>")
    @t << "<hr/>"
    @t << "<b>gems:install</b><br/>"
    @t << exec_cmd("rake gems:install").gsub("\n","<br/>")
    @t << "<hr/>"
    @t << "<b>db:migrate</b><br/>"
    @t << exec_cmd("rake db:migrate").gsub("\n","<br/>")
    @t << "<hr/>"
    @t << "<b>db:pull</b><br/>"
    h = "heroku db:pull postgres://postgres:songrit@localhost/elocal?encoding=utf8 --force --tables"
    @t << exec_cmd("#{h} gma_modules,gma_services").gsub("\n","<br/>")
    #@t << exec_cmd("#{h} cats,ptypes,plans,tasks").gsub("\n","<br/>")
    @t << exec_cmd("touch tmp/restart.txt").gsub("\n","<br/>")
    @t << "<hr/>"
  end
  def db_push_ms
    @t= exec_cmd('heroku db:push postgres://postgres:songrit@localhost/elocal?encoding=utf8 --force --tables gma_modules,gma_services').gsub("\n","<br/>")
  end

  def update_org
    org = Org.update 1,$xvars[:edit][:org]
    org.id
  end
  def users
    @users= User.paginate :page=>params[:page], :per_page=>25,
      :order=>:login
  end
  def hourly_housekeeping
    render :text => "hourly done"
  end
  def daily_housekeeping
    ActiveRecord::SessionStore::Session.destroy_all(
      ['updated_at < ?', 40.minutes.ago.utc])
    render :text => "daily done"
  end
  def destroy_gma
    GmaXmain.destroy_all
    GmaRunseq.destroy_all
    GmaDoc.destroy_all
    GmaSearch.destroy_all
    ActiveRecord::SessionStore::Session.destroy_all(
      ['updated_at < ?', 40.minutes.ago.utc])
    redirect_to "/admin/stat"
  end

  # gma methods
  def create_news
    get_xvars
    News.create @xvars[:enter_news][:news]
    gma_notice 'news created'
  end
end
