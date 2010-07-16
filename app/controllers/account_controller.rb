class AccountController < ApplicationController
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
end
