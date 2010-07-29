class AdminController < ApplicationController
  before_filter :admin_action, :except=>[:daily_housekeeping, :hourly_housekeeping]

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
    redirect_to "/admin/stat"
  end

  # gma methods
  def create_news
    get_xvars
    News.create @xvars[:enter_news][:news]
    gma_notice 'news created'
  end
end
