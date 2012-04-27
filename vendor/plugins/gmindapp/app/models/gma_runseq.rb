class GmaRunseq < ActiveRecord::Base
  belongs_to :gma_xmain
  belongs_to :gma_user
  named_scope "form_action", :conditions=>['action=? OR action=? OR action=?','form','output','pdf']
end
