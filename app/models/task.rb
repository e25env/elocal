class Task < ActiveRecord::Base
  belongs_to :plan
  has_many :budgets
  
  def budget
    budgets.sum('budget')
  end
  def balance
    budgets.sum('balance')
  end
end
