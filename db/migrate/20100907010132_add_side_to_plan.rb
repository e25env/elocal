class AddSideToPlan < ActiveRecord::Migration
  def self.up
    add_column :plans, :side_id, :integer
  end

  def self.down
    remove_column(:plans, :side_id)
  end
end
