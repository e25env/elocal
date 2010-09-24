class Revenue < ActiveRecord::Base
  belongs_to :rcat
  belongs_to :rtype

  before_save :set_name

  def set_name
    self.name= self.rtype.name
  end
end
