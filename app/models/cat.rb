class Cat < ActiveRecord::Base
  include ArMethods

  has_many :ptypes
  has_many :budgets

  def budget(fy=fiscal_year)
    budgets.sum('budget', :conditions=>{:fy=>fy})
  end
  def balance(fy=fiscal_year)
    budgets.sum('balance', :conditions=>{:fy=>fy})
  end

end
