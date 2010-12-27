class OfficeController < ApplicationController
  def sum_leave
    last_period= Date.today-180
    period_begin= Leave.period_begin(last_period)
    period_end= Leave.period_end(last_period)
    Employee.all.each do |e|
      leave_summary= LeaveSummary.first :conditions=>
        ["employee_id=? AND reported_on >= ? AND reported_on <= ?",
        e.id, period_begin, period_end]
      leave_summary.update_attribute(:reported_on, period_end) if leave_summary
      # add vacation if September
      if period_end.month==9
        e.leave_balance= 0 unless e.leave_balance
        # employee less than 6 months do not have vacation
        e.leave_balance += 10 unless (Date.today-e.begin_gov_service_on)<180
        service_year= Date.today.year - e.begin_gov_service_on.year
        case service_year
        when 0..9
          max= 20
        else
          max= 30
        end
        e.leave_balance= max if e.leave_balance > max
        e.save
      end
    end
    gma_notice "สรุปวันลางวด #{date_thai period_begin,:date_only=>true} - #{date_thai period_end, :date_only=>true} เรียบร้อยแล้ว"
    $xvars[:p][:return]= "/office/employee/#{$xvars[:p][:id]}?i=4"
  end
  def update_leave_balance
    employee= Employee.find $xvars[:p][:id]
    employee.update_attributes $xvars[:enter][:employee]
    gma_notice "บันทึกวันลาสะสมเรียบร้อยแล้ว"
    $xvars[:p][:return]= "/office/employee/#{$xvars[:p][:id]}?i=4"
  end
  def employee_photo
    @employee= Employee.find params[:id]
  end
  def rm_employee_photo
    ep= EmployeePhoto.find $xvars[:p][:id]
    employee_id= ep.employee_id
    gma_notice "ลบภาพถ่ายเรียบร้อยแล้ว"
    ep.destroy
    $xvars[:p][:return]= "/office/employee_photo/#{employee_id}"
  end
  def create_education
    e= Education.new $xvars[:enter][:education]
    e.employee_id= $xvars[:p][:id]
    e.save
    $xvars[:p][:return]= "/office/employee/#{$xvars[:p][:id]}?i=2"
  end
  def rm_education
    e= Education.find $xvars[:p][:id]
    employee_id= e.employee_id
    gma_notice "ลบข้อมูลการศึกษาเรียบร้อยแล้ว"
    e.destroy
    $xvars[:p][:return]= "/office/employee/#{employee_id}?i=2"
  end
  def create_training
    e= Training.new $xvars[:enter][:training]
    e.employee_id= $xvars[:p][:id]
    e.save
    $xvars[:p][:return]= "/office/employee/#{$xvars[:p][:id]}?i=2"
  end
  def rm_training
    d= Training.find $xvars[:p][:id]
    employee_id= d.employee_id
    gma_notice "ลบข้อมูลการฝึกอบรมเรียบร้อยแล้ว"
    d.destroy
    $xvars[:p][:return]= "/office/employee/#{employee_id}?i=2"
  end
  def create_decoration
    e= Decoration.new $xvars[:enter][:decoration]
    e.employee_id= $xvars[:p][:id]
    e.save
    $xvars[:p][:return]= "/office/employee/#{$xvars[:p][:id]}?i=1"
  end
  def rm_decoration
    d= Decoration.find $xvars[:p][:id]
    employee_id= d.employee_id
    gma_notice "ลบข้อมูลเครื่องราชอิสริยาภรณ์เรียบร้อยแล้ว"
    d.destroy
    $xvars[:p][:return]= "/office/employee/#{employee_id}?i=1"
  end
  def create_penalty
    e= Penalty.new $xvars[:enter][:penalty]
    e.employee_id= $xvars[:p][:id]
    e.save
    gma_notice "บันทึกข้อมูลความผิดทางวินัยแล้ว"
    $xvars[:p][:return]= "/office/employee/#{$xvars[:p][:id]}?i=3"
  end
  def rm_penalty
    d= Penalty.find $xvars[:p][:id]
    employee_id= d.employee_id
    gma_notice "ลบข้อมูลความผิดทางวินัยเรียบร้อยแล้ว"
    d.destroy
    $xvars[:p][:return]= "/office/employee/#{employee_id}?i=3"
  end
  def create_leave
    employee_id= $xvars[:p][:id]
    l= Leave.new $xvars[:enter][:leave]
    l.employee_id= employee_id
    l.reported_on= l.leave_begin
    l.save
    leave_summary= LeaveSummary.first :conditions=>["employee_id=? AND reported_on >= ? AND reported_on <= ?", employee_id, Leave.period_begin(l.leave_begin), Leave.period_end(l.leave_begin)]
    unless leave_summary
      leave_summary= LeaveSummary.create :reported_on=>l.leave_begin, :employee_id=>employee_id
    end
    leave_days= leave_summary.send("leave#{l.leave_type}")+l.total_days
    leave_summary.update_attribute "leave#{l.leave_type}", leave_days
    # vacation
    if l.leave_type==4
      employee= Employee.find employee_id
      employee.update_attribute :leave_balance, employee.leave_balance-l.total_days
    end
    gma_notice "บันทึกข้อมูลการลาเรียบร้อยแล้ว"
    $xvars[:p][:return]= "/office/employee/#{$xvars[:p][:id]}?i=4"
  end
  def rm_leave
    d= Leave.find $xvars[:p][:id]
    employee_id= d.employee_id
    gma_notice "ลบข้อมูลการลาเรียบร้อยแล้ว"
    d.destroy
    $xvars[:p][:return]= "/office/employee/#{employee_id}?i=4"
  end
  def create_job
    j= Job.new $xvars[:enter][:job]
    j.employee_id= $xvars[:p][:id]
    j.save
    $xvars[:p][:return]= "/office/employee/#{$xvars[:p][:id]}?i=1"
  end
  def rm_job
    j= Job.find $xvars[:p][:id]
    employee_id= j.employee_id
    gma_notice "ลบข้อมูลตำแหน่งเรียบร้อยแล้ว"
    j.destroy
    $xvars[:p][:return]= "/office/employee/#{employee_id}?i=1"
  end
  def create_employee_photo
    e= Employee.find $xvars[:p][:id]
    if $xvars[:enter][:employee_photo]
      ep= EmployeePhoto.create $xvars[:enter][:employee_photo]
      e.photo= ep.photo
      e.taken_on= ep.taken_on
      # scale file to 150
      filename= "doc/upload/f#{$xvars[:enter][:employee_photo_photo_doc_id]}"
      img_orig = Magick::Image.read(filename).first
#      tmp = "tmp/#{doc.filename}"
      if img_orig.columns > 150
        img = img_orig.resize_to_fit(150,150)
        img.write(filename)
      end
    end
    e.save
    $xvars[:p][:return]= "/office/employee_photo/#{e.id}"
  end
  def employee
    if Employee.exists? params[:id]
      @employee= Employee.find params[:id]
    else
      flash[:notice]="ขออภัย ไม่สามารถค้นหาเจ้าหน้าที่หมายเลข #{params[:id]}"
      redirect_to :action => "hr"
    end
  end
  def update_vision
    Vision.create $xvars[:edit][:vision]
  end
  def create_employee
    e= Employee.new $xvars[:enter][:employee]
    address= Address.create $xvars[:enter][:address]
    person= Person.create $xvars[:enter][:person]
    person.address_id= address.id
    person.save
    address_reg= Address.create $xvars[:enter][:address_reg]
    spouse= Person.create $xvars[:enter][:spouse]
    father= Person.create $xvars[:enter][:father]
    mother= Person.create $xvars[:enter][:mother]
    address_relative= Address.create $xvars[:enter][:address_relative]
    e.person_id= person.id
    e.address_id= address.id
    e.address_reg_id= address_reg.id
    e.address_relative_id= address_relative.id
    e.spouse_id= spouse.id
    e.father_id= father.id
    e.mother_id= mother.id
    e.status= 1
    e.retired_on= Date.new e.person.dob.year+60,9,30
    e.save
    $xvars[:employee_id]= e.id
    EmployeePhoto.create :employee_id=> e.id,
      :photo => e.photo,
      :taken_on => e.taken_on
    $xvars[:p][:return]= "/office/employee/#{e.id}"
    gma_notice "กรุณาเลือกแท็บตำแหน่ง, การศึกษา, ฯลฯ และใส่รายละเอียดเพิ่มเติมให้ครบถ้วนสมบูรณ์"
  end
  def update_employee
    employee= Employee.find $xvars[:p][:id]
    employee.update_attributes $xvars[:enter][:employee]
    employee.person.update_attributes $xvars[:enter][:person]
    employee.address.update_attributes $xvars[:enter][:address]
    employee.address_reg.update_attributes $xvars[:enter][:address_reg]
    employee.address_relative.update_attributes $xvars[:enter][:address_relative]
    employee.spouse.update_attributes $xvars[:enter][:spouse]
    employee.father.update_attributes $xvars[:enter][:father]
    employee.mother.update_attributes $xvars[:enter][:mother]
    gma_notice "แก้ไขข้อมูลเรียบร้อยแล้ว"
    $xvars[:p][:return]= "/office/employee/#{$xvars[:p][:id]}"
  end
  def rm_employee
    e= Employee.find $xvars[:p][:id]
    e.update_attribute :status, 2
    $xvars[:p][:return]= "/office/hr"
  end
  def create_student
    s= Student.new $xvars[:enter][:student]
    s.status= 1
    s.nursery_id= $xvars[:p][:id]
    s.save
    $xvars[:student_id]= s.id
    $xvars[:p][:return]= "/office/students/#{$xvars[:p][:id]}"
  end
  def students
    @nursery= Nursery.find params[:id]
  end
  def hr
    @employees= Employee.active
  end
  def policies
    @nurseries= Nursery.all
  end
  def nurseries
    @nurseries= Nursery.all
  end
  def create_nursery
    Nursery.create $xvars[:enter][:nursery]
    gma_notice "ขึ้นทะเบียนเรียบร้อยแล้ว"
    $xvars[:p][:return]="/office/nurseries"
  end
  def update_nursery
    nursery= Nursery.find $xvars[:p][:id]
    nursery.update_attributes $xvars[:edit][:nursery]
    gma_notice "แก้ไขข้อมูลเรียบร้อยแล้ว"
    $xvars[:p][:return]= "/office/nurseries"
  end
  def rm_nursery
    nursery= Nursery.find $xvars[:p][:id]
    gma_notice "ลบข้อมูลเรียบร้อยแล้ว"
    nursery.destroy
    $xvars[:p][:return]= "/office/nurseries"
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
    render :layout => "print", :template=>"office/senior_local"
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
      s.save
      gma_notice "ขึ้นทะเบียนผู้ด้อยโอกาสเรียบร้อยแล้ว"
    else
      gma_notice s.errors[:nid]
    end
    $xvars[:senior_id]= s.id
    $xvars[:p][:return]= "/office/seniors"
  end
  def update_senior
    senior= Senior.find $xvars[:p][:id]
    senior.update_attributes $xvars[:edit][:senior]
    gma_notice "แก้ไขข้อมูล #{senior.full_name} เรียบร้อยแล้ว"
    $xvars[:p][:return]= "/office/seniors"
  end
  def rm_senior
    senior= Senior.find $xvars[:p][:id]
    gma_notice "ลบข้อมูล #{senior.full_name} เรียบร้อยแล้ว"
    senior.destroy
    $xvars[:p][:return]= "/office/seniors"
  end
  def village_heads
    @village_heads= VillageHead.all :order=>"moo"
  end
  def create_village_head
    VillageHead.create $xvars[:enter][:village_head]
    gma_notice "ขึ้นทะเบียนผู้ใหญ่บ้านเรียบร้อยแล้ว"
    $xvars[:p][:return]="/office/village_heads"
  end
  def update_village_head
    village_head= VillageHead.find $xvars[:p][:id]
    village_head.update_attributes $xvars[:edit][:village_head]
    gma_notice "แก้ไขข้อมูล #{village_head.full_name} เรียบร้อยแล้ว"
    $xvars[:p][:return]= "/office/village_heads"
  end
  def rm_village_head
    village_head= VillageHead.find $xvars[:p][:id]
    gma_notice "ลบข้อมูล #{village_head.full_name} เรียบร้อยแล้ว"
    village_head.destroy
    $xvars[:p][:return]= "/office/village_heads"
  end
  def cars
    @cars= Car.all :order=>'vtype,brand'
  end
  def create_car
    car = Car.new $xvars[:enter_car][:car]
    car.save
    gma_notice "เพิ่มรถส่วนกลางเรียบร้อยแล้ว"
    $xvars[:p][:return]="/office/cars"
  end
  def rm_car
    car= Car.find $xvars[:p][:id]
    gma_notice "ลบข้อมูลรถส่วนกลาง #{car.name} เรียบร้อยแล้ว"
    car.destroy
    $xvars[:p][:return]="/office/cars"
  end
  def create_doc_in
    doc= Doc.new $xvars[:register][:doc]
    doc.dtype= 1
    doc.save
    $xvars[:doc_id]= doc.id
    # $xvars[:action]= {:assign=>User.find_by_login('pornchai').id}
    set_songrit(:num_in, doc.rnum+1)
  end
  def create_doc_out
    doc= Doc.new $xvars[:register][:doc]
    doc.dtype= 2
    doc.save
    $xvars[:doc_id]= doc.id
    set_songrit(:num_out, doc.rnum+1)
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
  
  # ajax
  def car_schedule
    if params[:id]
      car= Car.find params[:id]
      t = []
      car.car_requests.active.each do |r|
        t << "#{date_thai r.schedule_at} #{r.name} (#{r.destination})"
      end
      render :text=> t.join('<br/>')
    else
      render :text=> ""
    end
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
  
  private
  def self.assigned?
    return $xvars[:action] ? $xvars[:action][:assign].to_i==$user.id : false
  end
end
