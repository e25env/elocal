class Employee < ActiveRecord::Base
  has_many :employee_photos, :order=>"taken_on"
  has_many :jobs, :order=>"effective_on"
  has_many :decorations, :order=>"received_on"
  has_many :educations, :order=>"edu_end"
  has_many :trainings, :order=>"train_end"
  has_many :penalties, :order=>"issued_on"
  has_many :leaves, :order=>"leave_begin", :class_name => "Leave"
  has_many :leave_summaries, :order=>"reported_on"

  belongs_to :section
  belongs_to :sub_district
  belongs_to :district
  belongs_to :province
  belongs_to :sub_district_reg, :class_name => "SubDistrict"
  belongs_to :district_reg, :class_name => "District"
  belongs_to :province_reg, :class_name => "Province"
  belongs_to :parent_sub_district, :class_name => "SubDistrict"
  belongs_to :parent_district, :class_name => "District"
  belongs_to :parent_province, :class_name => "Province"
#  belongs_to :education_level

  def full_name
    "#{title}#{fname} #{lname}"
  end
  def father_full_name
    return father_fname.blank? ? "-" : "นาย#{father_fname} #{father_lname}"
  end
  def mother_full_name
    return mother_fname.blank? ? "-" : "#{mother_title}#{mother_fname} #{mother_lname}"
  end
  def spouse_full_name
    return spouse_fname.blank? ? "-" : "#{spouse_title}#{spouse_fname} #{spouse_lname}"
  end
end
