class Construction < ActiveRecord::Base
  has_many :construction_details
  belongs_to :applicant, :class_name => "Person" 
  belongs_to :building_owner, :class_name => "Person" 
  belongs_to :land_owner, :class_name => "Person" 
  belongs_to :engineer, :class_name => "Person" 
  belongs_to :architect, :class_name => "Person" 
  belongs_to :site, :class_name => "Address" 
  
  APPLICANT_TYPE= ['บุคคลธรรมดา','นิติบุคคล']
  CONSTRUCTION_TYPE= ['ก่อสร้างอาคาร','ดัดแปลงอาคาร','รื้อถอนอาคาร']
  PURPOSE= ['ที่พักอาศัย','การพาณิชย์','อุตสาหกรรม','อื่นๆ']
  LAND_DOC_TYPE= ['โฉนดที่ดิน','น.ส. 3','ส.ค.1']
  CITY_PLAN_ZONE= ['พื้นที่สีเขียว','พื้นที่สีเหลือง','พื้นที่สีส้ม','พื้นที่สีน้ำตาล']
  CONSTRUCTION_STATUS= ['ยังไม่มีการก่อสร้าง','อยู่ระหว่างการก่อสร้าง','ดำเนินการก่อสร้างเสร็จแล้ว']
  
  def construction_type_name
    CONSTRUCTION_TYPE[construction_type]
  end
  def land_doc_name
    LAND_DOC_TYPE[land_doc_type]
  end
  def purpose_name
    PURPOSE[purpose]
  end
  def construction_status_name
    CONSTRUCTION_STATUS[construction_status]
  end
  def city_plan_zone_name
    CITY_PLAN_ZONE[city_plan_zone]
  end
end
