class Plan < ActiveRecord::Base
  has_many :tasks
end
