class Land < ActiveRecord::Base
  belongs_to :owner, :class_name=>"Person"
  belongs_to :utilizer, :class_name=>"Person"

  def landcode
    return land_code.blank? ? "" : "#{land_code} #{pt4_code} (#{id})"
  end
end
