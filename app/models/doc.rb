class Doc < ActiveRecord::Base
  def icon
    case dtype
    when 1
      "arrow_right.png"
    when 2
      "arrow_turn_left.png"
    when 3
      "page_green.png"
    end
    # return dtype==1 ? "arrow_right.png" : "arrow_turn_left.png"
  end
  def title
    case dtype
    when 1
      "เอกสารเข้า"
    when 2
      "เอกสารออก"
    when 3
      "บันทึกข้อความ"
    end
    # return dtype==1 ? "arrow_right.png" : "arrow_turn_left.png"
  end
  def process_at_time
    default= process_at || Time.now
    default.strftime('%R')
    # "#{p.hour}:#{p.min}"
  end
  def process_at_time=(t)
    @process_at_time= t
  end
  def before_create 
    if process_at && @process_at_time
      d = process_at.strftime('%F ')
      write_attribute "process_at", d+@process_at_time
    end
  end
end
