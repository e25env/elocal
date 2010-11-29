class Leave < ActiveRecord::Base
  def leave_type_name
    case leave_type
    when 1
      "ลาป่วย"
    when 1
      "ลากิจ"
    when 1
      "ขาดราชการ"
    when 1
      "ลาศึกษาต่อ"
    else
      ""
    end
  end
end
