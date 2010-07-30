class AddLevelsDoc < ActiveRecord::Migration
  def self.up
    add_column :docs, :ref, :string
    add_column :docs, :confidential_id, :integer
    add_column :docs, :urgent_id, :integer
  end

  def self.down
    remove_column(:docs, :ref)
    remove_column(:docs, :confidential_id)
    remove_column(:docs, :urgent_id)
  end
end
