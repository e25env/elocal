class Ptype < ActiveRecord::Base
  include ArMethods
  belongs_to :cat
  has_many :budgets
  
  def budget(fy=fiscal_year)
    budgets.sum('budget', :conditions=>{:fy=>fy})
  end
  def balance(fy=fiscal_year)
    budgets.sum('balance', :conditions=>{:fy=>fy})
  end
  
end
