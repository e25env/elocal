class AddPollZoneToAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :poll_zone_id, :integer
  end

  def self.down
    remove_column :addresses, :poll_zone_id
  end
end
