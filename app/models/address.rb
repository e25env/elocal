class Address < ActiveRecord::Base
  belongs_to :head_person, :class_name => "Person"
  belongs_to :sub_district
  belongs_to :district
  belongs_to :province

  def address_name
    a= ""
    a += "#{address} " if address&&!address.try(:empty?)
    a += "ซอย#{soi} " if soi&&!soi.try(:empty?)
    a += "ถนน#{street} " if street&&!street.try(:empty?)
    a += "หมู่ #{moo} " if moo&&!moo.to_s.try(:empty?)
    a += "ต. #{sub_district.name} "
    a += "อ. #{district.name} จ. #{province.name}"
  end
end
