class VillageHead < ActiveRecord::Base
  def full_name
    "#{title}#{fname} #{lname}"
  end
end
