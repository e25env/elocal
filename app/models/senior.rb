class Senior < ActiveRecord::Base
  def nid=(val)
    self[:nid]= val.gsub(/[\s-]/,'')
  end
  def full_name
    "#{title}#{fname} #{lname}"
  end
end
