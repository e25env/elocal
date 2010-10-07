class Rcat < ActiveRecord::Base
  default_scope :order => 'id'
  has_many :revenues, :order=>:id
  has_many :rtypes

  def rtypes_fy(fy)
     revenues= Revenue.all :conditions=>{:fy=>fy, :rcat_id=>id}
     Rtype.find revenues.map(&:rtype_id)
  end
end
