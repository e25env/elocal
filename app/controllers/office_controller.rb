class OfficeController < ApplicationController
  def create_doc_in
    doc= Doc.create $xvars[:register][:doc]
    $xvars[:doc_id]= doc.id
    $xvars[:action]= {:assign=>User.find_by_login('pornchai').id}
    set_songrit(:rnum, doc.rnum+1)
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
