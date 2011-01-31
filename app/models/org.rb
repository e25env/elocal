class Org < ActiveRecord::Base
  def self.full_name
    o= self.last
    "#{o.otype_abbrev}. #{o.name}"
  end
  def self.head_report
    org= self.last
    "#{org.otype}#{org.name} อำเภอ#{org.district} จังหวัด#{org.province}"
  end
end
