class AccountController < ApplicationController
  def create_bike_request
    car= Car.new $xvars[:enter][:car]
    car.vtype= 1
    car.save
    $xvars[:car_id]= car.id
    $xvars[:section_id] = $user.section_id
  end
  def update_car
    car= Car.find $xvars[:car_id]
    car.update_attributes $xvars[:scan][:car]
  end
  def create_memo
    doc= Doc.new $xvars[:new][:doc]
    doc.dtype= 3
    doc.save
    $xvars[:doc_id]= doc.id
    $xvars[:action]= {:assign=>$xvars[:new][:assign]}
    u = User.find $user_id
    $xvars[:section_id] = u.section_id
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
