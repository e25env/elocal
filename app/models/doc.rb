class Doc < ActiveRecord::Base
  def icon
    return dtype==1 ? "arrow_right.png" : "arrow_turn_left.png"
  end
end
