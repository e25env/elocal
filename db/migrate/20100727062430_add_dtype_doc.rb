class AddDtypeDoc < ActiveRecord::Migration
  def self.up
    add_column :docs, :dtype, :integer
  end

  def self.down
    remove_column(:docs, :dtype)
  end
end
