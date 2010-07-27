class GmaXmain < ActiveRecord::Base
  unloadable

  belongs_to :gma_service
  belongs_to :gma_user
  has_many :gma_runseqs, :order=>"rstep"
  has_many :comments, :order=>"created_at"
  has_many :gma_docs, :order=>"created_at"

  serialize :xvars

  # number of xmains on the specified date
  def self.number(d)
    all(:conditions=>['DATE(created_at) =?', d.to_date]).count
  end
end
