class ConstructionDetail < ActiveRecord::Base
  BUILDING_TYPE = ['คสล.','ไม้','เหล็ก']
  def building_type_name
    BUILDING_TYPE[building_type]
  end
  def floors_name
    if floors==1
      "ชั้นเดียว"
    else
      "#{floors} ชั้น"
    end
  end
  def purpose_name
    Construction::PURPOSE[purpose]
  end
end
