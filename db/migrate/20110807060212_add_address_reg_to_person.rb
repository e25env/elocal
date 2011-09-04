class AddAddressRegToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :address_reg_id, :integer
  end

  def self.down
    remove_column :people, :address_reg_id
  end
end
