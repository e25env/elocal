class CarRequest < ActiveRecord::Base
  belongs_to :car
  named_scope :active, :conditions=>['schedule_at > ?', Time.now]
end
