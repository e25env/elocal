class AddEmployeeIdToGmaUser < ActiveRecord::Migration
  def self.up
    add_column :gma_users, :employee_id, :integer
  end

  def self.down
    remove_column :gma_users, :employee_id
  end
end
