class Plan < ActiveRecord::Base
  belongs_to :side
  has_many :tasks
end
