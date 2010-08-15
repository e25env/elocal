class Payment < ActiveRecord::Base
  has_many :payment_details
  belongs_to :section
  belongs_to :plan
  belongs_to :task
  belongs_to :cat
  belongs_to :ptype
  belongs_to :requester, :class_name=>'User'
  belongs_to :budgeter, :class_name=>'User'
  belongs_to :inspector, :class_name=>'User'
end
