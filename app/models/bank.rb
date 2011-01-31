class Bank < ActiveRecord::Base
  def full_name
    "#{name} #{atype_name} สาขา#{branch} เลขที่ #{account}"
  end
  
  def atype_name
    case atype
    when 1
      "ออมทรัพย์"
    when 2
      "กระแสรายวัน"
    when 3
      "ประจำ 3 เดือน"
    when 4
      "ประจำ 6 เดือน"
    end
  end
end
