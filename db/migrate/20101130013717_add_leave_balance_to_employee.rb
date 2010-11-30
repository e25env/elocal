class AddLeaveBalanceToEmployee < ActiveRecord::Migration
  def self.up
    add_column :employees, :leave_balance, :integer
  end

  def self.down
    remove_column :employees, :leave_balance
  end
end
