class Income < ActiveRecord::Base
  has_many :income_details
  belongs_to :deliver, :class_name=>'User'
  belongs_to :receiver, :class_name=>'User'
end
