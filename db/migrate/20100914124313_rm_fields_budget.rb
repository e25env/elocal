class RmFieldsBudget < ActiveRecord::Migration
  def self.up
    remove_column(:budgets, :code)
    remove_column(:budgets, :name)
    remove_column(:budgets, :code_laas)
    remove_column(:budgets, :account_number)
  end

  def self.down
    add_column(:budgets, :code, :string)
    add_column(:budgets, :name, :string)
    add_column(:budgets, :code_laas, :string)
    add_column(:budgets, :account_number, :string)
  end
end
