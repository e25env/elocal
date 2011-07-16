class Address < ActiveRecord::Base
  belongs_to :head_person, :class_name => "Person"
  belongs_to :sub_district
  belongs_to :district
  belongs_to :province

  def name(o={})
    a= ""
    a += "#{address} " if address&&!address.try(:empty?)
    a += "ซอย#{soi} " if soi&&!soi.try(:empty?)
    a += "ถนน#{street} " if street&&!street.try(:empty?)
    a += "หมู่ที่ #{moo} " if moo&&!moo.to_s.try(:empty?)
    if o[:full]
      a += "ตำบล#{sub_district.name} "
      a += "อำเภอ#{district.name} จังหวัด#{province.name}"
    else
      a += "ต. #{sub_district.name} "
      a += "อ. #{district.name} จ. #{province.name}"
    end
  end
end
