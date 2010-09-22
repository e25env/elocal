class RmFy < ActiveRecord::Migration
  def self.up
    remove_column(:cats, :fy)
    remove_column(:cats, :budget)
    remove_column(:cats, :balance)
    add_column(:cats, :account_number, :integer)
    remove_column(:ptypes, :fy)
    remove_column(:ptypes, :budget)
    remove_column(:ptypes, :balance)
    add_column(:ptypes, :account_number, :integer)
    remove_column(:plans, :fy)
    remove_column(:plans, :budget)
    remove_column(:plans, :balance)
    remove_column(:tasks, :fy)
    remove_column(:tasks, :budget)
    remove_column(:tasks, :balance)
  end

  def self.down
    add_column(:cats, :fy, :integer)
    add_column(:cats, :budget, :float)
    add_column(:cats, :balance, :float)
    add_column(:ptypes, :fy, :integer)
    add_column(:ptypes, :budget, :float)
    add_column(:ptypes, :balance, :float)
    add_column(:plans, :fy, :integer)
    add_column(:plans, :budget, :float)
    add_column(:plans, :balance, :float)
    add_column(:tasks, :fy, :integer)
    add_column(:tasks, :budget, :float)
    add_column(:tasks, :balance, :float)
  end
end
