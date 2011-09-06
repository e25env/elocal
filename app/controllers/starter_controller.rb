class StarterController < ApplicationController
  def index
    respond_to do |format|
      format.html { @docs= Doc.paginate :page=>params[:page], :order => "created_at DESC" }
      # format.pdf { @docs= Doc.all :order => "created_at DESC" }
    end
  end
  def sections
    @sections= Section.all
  end
  def cars
    @cars= Car.all :order=>'vtype,brand'
  end
  
  # gma
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
end
