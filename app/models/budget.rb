class Budget < ActiveRecord::Base
  include ArMethods
  before_save :set_name

  belongs_to :fsection
  belongs_to :cat
  belongs_to :ptype
  belongs_to :plan
  belongs_to :task

  has_many :payments

  def set_name
    self.name= self.ptype.name
  end
end
