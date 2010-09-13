class AddCatPlan2budget < ActiveRecord::Migration
  def self.up
    add_column :budgets, :cat_id, :integer
    add_column :budgets, :plan_id, :integer
  end

  def self.down
    remove_column(:budgets, :cat_id)
    remove_column(:budgets, :plan_id)
  end
end
