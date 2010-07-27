class OfficeController < ApplicationController
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
  def save_comment
    comment = Comment.create(:content=>$xvars[:action][:comment], :gma_xmain_id=>$xmain.id)
    comment.id
  end

  private
  def self.assigned?
    return $xvars[:action] ? $xvars[:action][:assign].to_i==$user.id : false
  end
end
