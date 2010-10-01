class LaasQueue < ActiveRecord::Base
  named_scope :active, :conditions=>['status IN (0,2)']
  def status_icon
    case status
    when 0
      "clock.png"
    when 2
      "logout.png"
    end
  end
  def submit(ff)
    eval(script)
  end
end
