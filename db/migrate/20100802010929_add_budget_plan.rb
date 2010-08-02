class AddBudgetPlan < ActiveRecord::Migration
  def self.up
    add_column :plans, :budget, :float
    add_column :plans, :balance, :float
  end

  def self.down
    remove_column(:plans, :budget)
    remove_column(:plans, :balance)
  end
end
