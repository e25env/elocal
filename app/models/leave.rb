class Leave < ActiveRecord::Base
  def self.period_end(d=Date.today)
    y= d.year
    case d.month
    when 1..3
      period_end= Date.new y,3,30
    when 4..9
      period_end= Date.new y,9,30
    when 10..12
      period_end= Date.new y+1,3,30
    end
    return period_end
  end
  def self.period_begin(d=Date.today)
    Leave.last_period_end(d)+1
  end
  def self.last_period_end(d=Date.today)
    Leave.period_end(d-180)
  end
  def leave_type_name
    case leave_type
    when 1
      "ลาป่วย"
    when 2
      "ลาคลอดบุตร"
    when 3
      "ลากิจ"
    when 4
      "ลาพักผ่อน"
    when 5
      "ลาอุปสมบท"
    when 6
      "ลาราชการทหาร"
    when 7
      "ลาศึกษาต่อ"
    when 8
      "ลาองค์กรระหว่างประเทศ"
    when 9
      "ลาติดตามคู่สมรส"
    when 10
      "มาสาย"
    when 11
      "ขาดราชการ"
    else
      ""
    end
  end
end