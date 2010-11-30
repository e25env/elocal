class Leave < ActiveRecord::Base
  def this_period?(d=Date.today)
    y= reported_on.year
    case reported_on.month
    when 1..3
      period_end= Date.new y,3,30
    when 4..9
      period_end= Date.new y,9,30
    when 10..12
      period_end= Date.new y+1,3,30
    end
    d <= period_end
  end
  def leave_type_name
    case leave_type
    when 1
      "ลาป่วย"
    when 2
      "ลากิจ"
    when 3
      "มาสาย"
    when 4
      "ขาดราชการ"
    when 5
      "ลาศึกษาต่อ"
    else
      ""
    end
  end
end
