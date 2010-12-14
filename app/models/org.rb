class Org < ActiveRecord::Base
  def self.full_name
    o= self.last
    "#{o.otype_abbrev}. #{o.name}"
  end
end
