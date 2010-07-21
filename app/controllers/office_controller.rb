class OfficeController < ApplicationController
  def create_doc_in
    get_xvars
    doc= Doc.create @xvars[:register][:doc]
    @xvars[:doc_id]= doc.id
    set_songrit(:rnum, doc.rnum+1)
    save_xvars
  end

  private
  def self.assigned?
#    debugger
    @xvars= $xmain.xvars
    if @xvars[:action]
      return @xvars[:action][:assign].to_i==$user.id
    else
      return @xvars[:assign][:assign].to_i==$user.id
    end
  end
end
