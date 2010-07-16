class GmaXmain < ActiveRecord::Base
  belongs_to :gma_service
  belongs_to :gma_user
  has_many :gma_runseqs, :order=>"rstep"
  serialize :xvars

  # number of xmains on the specified date
  def self.number(d)
    all(:conditions=>['DATE(created_at) =?', d.to_date]).count
  end
end
