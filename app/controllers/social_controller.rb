class SocialController < ApplicationController
  def index
    redirect_to :action => "seniors"
  end
  def senior_local
    @budget= 1
    @budget_title= "งบท้องถิ่น"
    @village_heads= VillageHead.all :order=>:moo
    render :layout => "print"
  end
  def senior_state
    @budget= 2
    @budget_title= "งบรัฐบาล"
    @village_heads= VillageHead.all :order=>:moo
    render :layout => "print", :template=>"social/senior_local"
  end
  def seniors
    @seniors= Senior.all :order=>'moo,fname'
  end
  def create_senior
    s= Senior.new $xvars[:enter][:senior]
    if s.save
      gma_notice "ขึ้นทะเบียนผู้รับเบี้ยยังชีพเรียบร้อยแล้ว" 
      $xvars[:senior_id]= s.id
    else
      gma_notice "ขออภัย บุคคลนี้มีชื่ออยู่ในระบบแล้ว ไม่สามารถขึ้นทะเบียนได้" 
    end
    $xvars[:p][:return]= "/social/seniors"
  end
  def update_senior
    senior= Senior.find $xvars[:p][:id]
    senior.update_attributes $xvars[:edit][:senior]
    gma_notice "แก้ไขข้อมูล #{senior.full_name} เรียบร้อยแล้ว"
    $xvars[:p][:return]= "/social/seniors"
  end
  def rm_senior
    senior= Senior.find $xvars[:p][:id]
    gma_notice "ลบข้อมูล #{senior.full_name} เรียบร้อยแล้ว"
    senior.destroy
    $xvars[:p][:return]= "/social/seniors"
  end
end
