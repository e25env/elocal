class CreatePollZoneUnits < ActiveRecord::Migration
  def self.up
    create_table :poll_zone_units, :force=>true do |t|
      t.integer :poll_zone_id
      t.integer :address_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :poll_zone_units
  end
end
