class Cat < ActiveRecord::Base
  has_many :budgets
  has_many :ptypes, :through=>:budgets
end
