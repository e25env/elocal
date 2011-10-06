class Doc < ActiveRecord::Base
  def icon
    return dtype==1 ? "arrow_right.png" : "arrow_turn_left.png"
  end
  def process_at_time
    process_at.strftime('%R')
    # "#{p.hour}:#{p.min}"
  end
  def process_at_time=(t)
    @process_at_time= t
  end
  def before_create
    d = process_at.strftime('%F ')
    # write_attribute "process_at", DateTime.parse(d+t)
    write_attribute "process_at", d+@process_at_time
    # puts d+t
  end
end
