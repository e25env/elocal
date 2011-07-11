class Address < ActiveRecord::Base
  belongs_to :head_person, :class_name => "Person"
  belongs_to :sub_district
  belongs_to :district
  belongs_to :province

  def address_name
    a= "#{address}"
    a += " ซอย#{soi}" unless soi.empty?
    a += " ถนน#{street}" unless street.empty?
    a += " หมู่#{moo}" unless moo.to_s.empty?
    a += " ต. #{sub_district.name}"
    a += " อ. #{district.name} จ. #{province.name}"
  end
end
