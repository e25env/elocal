class AddYearBudget < ActiveRecord::Migration
  def self.up
    add_column :cats, :fy, :integer
    add_column :ptypes, :fy, :integer
    add_column :plans, :fy, :integer
    add_column :tasks, :fy, :integer
  end

  def self.down
    remove_column(:cats, :fy)
    remove_column(:ptypes, :fy)
    remove_column(:plans, :fy)
    remove_column(:tasks, :fy)
  end
end
