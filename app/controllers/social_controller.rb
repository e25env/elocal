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
    address= Address.create $xvars[:enter][:address]
    if SUB_DISTRICT_ID
      address.sub_district_id= SUB_DISTRICT_ID
    end
    address.district_id= DISTRICT_ID
    address.province_id= PROVINCE_ID
    address.save
    if Person.exists? :nid=>$xvars[:enter][:person][:nid]
      person= Person.find_by_nid $xvars[:enter][:person][:nid]
    else
      person= Person.create $xvars[:enter][:person]
      person.address_id= address.id
      person.save
    end
    s= Senior.create $xvars[:enter][:senior]
    if s.id
      s.person_id= person.id
      s.fname= person.fname
      s.moo= address.moo
      s.address= address
      s.save
      gma_notice "ขึ้นทะเบียนผู้รับเบี้ยยังชีพเรียบร้อยแล้ว"
    else
      gma_notice s.errors[:nid]
    end
    $xvars[:senior_id]= s.id
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
