class AccountController < ApplicationController
  def cancel_car_request
    requests= $xvars[:select_request][:car_request]
    if requests
      CarRequest.find(requests).each do |r|
        r.gma_xmain.update_attribute :status,'X'
        r.destroy
      end
    end
  end
  def create_car_request
    car_request= CarRequest.new $xvars[:enter][:car_request]
    car_request.gma_xmain_id= $xmain.id
    car_request.save
    $xvars[:car_id]= car_request.id
    $xvars[:section_id] = $user.section_id
  end
  def update_car
    car_request= CarRequest.find $xvars[:car_id]
    car_request.update_attributes $xvars[:scan][:car_request]
  end
  def create_memo
    doc= Doc.new $xvars[:register][:doc]
    doc.dtype= 3
    doc.save
    $xvars[:doc_id]= doc.id
    #$xvars[:action]= {:assign=>$xvars[:new][:assign]}
    #u = User.find $user_id
    #$xvars[:section_id] = u.section_id
  end
  def save_comment
    comment = Comment.create(:content=>$xvars[:action][:comment], :gma_xmain_id=>$xmain.id)
    comment.id
    unless $xvars[:section_id]
      if $xvars[:action][:assign]
        u = User.find $xvars[:action][:assign].to_i
        $xvars[:section_id]= u.section_id
      else
        # default to สำนักปลัด if not assign
        $xvars[:section_id]= 1
      end
    end
  end
  def update_user
    u= User.find $user_id
    u.update_attributes $xvars[:enter_user][:user]
    gma_notice "แก้ไขข้อมูลผู้ใช้เรียบร้อยแล้ว"
  end
  def change_password
    get_xvars
    u= User.find $user_id
    if User.authenticate u.login, @xvars[:enter][:pwd_old]
      u.password= @xvars[:enter][:pwd_new]
      u.save
      gma_notice "แก้ไขรหัสผ่านเรียบร้อยแล้ว"
    else
      gma_notice "รหัสผ่านไม่ถูกต้อง กรุณาติดต่อผู้ดูแลระบบ"
    end
  end
  def index
    @u= current_user
  end
end
