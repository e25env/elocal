class AddInspectorPayment < ActiveRecord::Migration
  def self.up
    add_column :payments, :requester_id, :integer
    add_column :payments, :requester_position, :string
    add_column :payments, :budgeter_id, :integer
    add_column :payments, :budgeter_position, :string
    add_column :payments, :inspector_id, :integer
    add_column :payments, :inspector_position, :string
  end

  def self.down
    remove_column :payments, :requester_id
    remove_column :payments, :requester_position
    remove_column :payments, :budgeter_id
    remove_column :payments, :budgeter_position
    remove_column :payments, :inspector_id
    remove_column :payments, :inspector_position
  end
end
