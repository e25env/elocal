class Poll < ActiveRecord::Base
  has_many :poll_selections
  default_scope :order=>"start_on DESC"
  
  def scope_name
    ["หมู่บ้าน","ตำบล"][scope]
  end
end
