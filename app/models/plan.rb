class Plan < ActiveRecord::Base
  belongs_to :side
  has_many :tasks
  has_many :budgets
end
