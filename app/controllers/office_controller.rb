class OfficeController < ApplicationController
  def create_car_request
    car= Car.new $xvars[:enter][:car]
    car.vtype= 0
    car.save
    $xvars[:car_id]= car.id
    $xvars[:section_id] = $user.section_id
  end
  def update_car
    car= Car.find $xvars[:car_id]
    car.update_attributes $xvars[:scan][:car]
  end
  def create_doc_in
    doc= Doc.new $xvars[:register][:doc]
    doc.dtype= 1
    doc.save
    $xvars[:doc_id]= doc.id
    $xvars[:action]= {:assign=>User.find_by_login('pornchai').id}
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

  private
  def self.assigned?
    return $xvars[:action] ? $xvars[:action][:assign].to_i==$user.id : false
  end
end
