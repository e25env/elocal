class Construction < ActiveRecord::Base
  has_many :construction_details
  belongs_to :applicant, :class_name => "Person" 
  belongs_to :site, :class_name => "Address" 
  
  def construction_type_name
    ['ก่อสร้างอาคาร','ดัดแปลงอาคาร','รื้อถอนอาคาร'][construction_type+1]
  end
end
