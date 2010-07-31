class GmaDoc < ActiveRecord::Base
  belongs_to :gma_runseq
  belongs_to :gma_service
  belongs_to :gma_user

  def self.search(q, page, per_page=10)
    paginate :per_page=>per_page, :page => page, :conditions =>
      ["content_type=? AND data_text LIKE ?", "output", "%#{q}%" ],
      :order=>'gma_xmain_id DESC', :select=>'DISTINCT gma_xmain_id'
  end
end
