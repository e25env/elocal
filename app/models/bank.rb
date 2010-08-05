class Bank < ActiveRecord::Base
  def full_name
    "#{name} #{account}"
  end
end
