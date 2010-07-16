module GmaHelper
  def status_icon(s)
    case s
    when 'R'
      image_tag 'user.png'
    when 'F'
      image_tag 'tick.png'
    when 'I'
      image_tag 'control_play.png'
    when 'E'
      image_tag 'logout.png'
    when 'X'
      image_tag 'cross.png'
    else
      image_tag 'cancel.png'
    end
  end
end
