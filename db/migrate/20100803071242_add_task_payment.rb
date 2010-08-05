class AddTaskPayment < ActiveRecord::Migration
  def self.up
    add_column :payments, :task_id, :integer
  end

  def self.down
    remove_column(:payments, :task_id)
  end
end
