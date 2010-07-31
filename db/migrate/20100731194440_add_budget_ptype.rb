class AddBudgetPtype < ActiveRecord::Migration
  def self.up
    add_column :ptypes, :cat_id, :integer
    add_column :ptypes, :budget, :float
    add_column :ptypes, :balance, :float
    add_column :cats, :budget, :float
    add_column :cats, :balance, :float
  end

  def self.down
    remove_column(:ptypes, :cat_id)
    remove_column(:ptypes, :budget)
    remove_column(:ptypes, :balance)
    remove_column(:cats, :budget)
    remove_column(:cats, :balance)
  end
end
