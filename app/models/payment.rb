class Payment < ActiveRecord::Base
  has_many :payment_details
  belongs_to :section
  belongs_to :plan
  belongs_to :task
  belongs_to :cat
  belongs_to :ptype
end
