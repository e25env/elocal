class Budget < ActiveRecord::Base
  belongs_to :fsection
  belongs_to :cat
  belongs_to :ptype
  belongs_to :plan
  belongs_to :task

  before_save :set_name

  def set_name
    self.name= self.ptype.name
  end
end
