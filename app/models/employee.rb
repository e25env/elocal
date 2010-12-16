class Employee < ActiveRecord::Base
  named_scope :active, :conditions=>"status=1"

  has_many :employee_photos, :order=>"taken_on"
  has_many :jobs, :order=>"effective_on"
  has_many :decorations, :order=>"received_on"
  has_many :educations, :order=>"edu_end"
  has_many :trainings, :order=>"train_end"
  has_many :penalties, :order=>"issued_on"
  has_many :leaves, :order=>"leave_begin", :class_name => "Leave"
  has_many :leave_summaries, :order=>"reported_on"

  belongs_to :person
  belongs_to :address
  belongs_to :address_reg, :class_name=>"Address"
  belongs_to :address_relative, :class_name=>"Address"
  belongs_to :spouse, :class_name=>"Person"
  belongs_to :mother, :class_name=>"Person"
  belongs_to :father, :class_name=>"Person"

  belongs_to :section
  belongs_to :education_level

end
