class UsersController < ApplicationController
#  require "Gma"
#  include GmaMethods
  def login
    user= GmaUser.authenticate params[:login], params[:password]
    if user
      session[:user_id]= user.id
      $user_id= user.id
#      gma_log "LOGIN", "user #{user.login}(#{user.id}) logged in"
    else
      gma_log "SECURITY", "user #{params[:login]} log in failure"
      flash[:notice]= "ขออภัย รหัสไม่ถูกต้อง"
      gma_notice "ขออภัย รหัสไม่ถูกต้อง"
    end
    # redirect_to request.referrer
    # redirect_to :controller=>'main', :action => "pending"
  end
  def logout
#    gma_log "LOGOUT", "user #{current_user.login}: #{current_user.id} logged out"
    session[:user_id]= nil
    $user_id= anonymous.id
    # redirect_to :controller => "main", :action => "about"
    render :text=>"<script>window.location.assign('/main/home');</script>", :layout => true 
  end
  def new
    @title= "Register New User"
    @user= GmaUser.new :role=>"M"
  end
  def create
    @user= GmaUser.new params[:user]
    if @user.save
      flash[:notice]= "ขึ้นทะเบียนเรียบร้อยแล้ว"
      gma_notice "ขึ้นทะเบียนเรียบร้อยแล้ว"
      redirect_to "/"
    else
      @user.password= ""
      flash[:notice]= "ขออภัย ไม่สามารถขึ้นทะเบียนได้"
      gma_notice "ขออภัย ไม่สามารถขึ้นทะเบียนได้"
      render :action=>:new
    end
  end

  # ajax
  def subsections
    @section= Section.find params[:id]
#    include ActionView::Helpers::FormOptionsHelper
    render :text => @template.options_from_collection_for_select(@section.subsections, :id, :name)
  end
  def check_login
    red = "#FF796C" ; green = "#B5D19D"
    if params[:login].blank?
      m = "CODE MUST NOT BE BLANK" ; c = red
    elsif User.exists?(:login=>params[:login])
      m = "CODE ALREADY EXISTS" ; c = red
    else
      m = "OK" ; c = green
    end
    t= c==green ? "<img src='/images/tick.png'>" : "<img src='/images/cross.png'>"
    render :text => "#{t} <span class='status' style='background-color:#{c}'>#{m}</span>"
  end
end