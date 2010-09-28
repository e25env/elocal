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
  def ptypes_fy(fsection,fy=fiscal_year)
    ptypes= budgets.find(:all, :conditions=>{:fy=>fy,:fsection_id=>fsection}).map(&:ptype_id).uniq.sort
    Ptype.find ptypes
  end

end
