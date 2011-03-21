class Land < ActiveRecord::Base
  belongs_to :owner, :class_name=>"Person"
  belongs_to :utilizer, :class_name=>"Person"
end
