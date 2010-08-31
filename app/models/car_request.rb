class CarRequest < ActiveRecord::Base
  belongs_to :car
  belongs_to :gma_xmain
  named_scope :active, :conditions=>['schedule_at > ?', Time.now]
end
