class Sign < ActiveRecord::Base
  belongs_to :owner, :class_name=>"Person"
  belongs_to :location, :class_name=>"Address"
end
