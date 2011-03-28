class CreateBuildings < ActiveRecord::Migration
  def self.up
    create_table :buildings, :force=>true do |t|
      t.integer :owner_id
      t.integer :utilizer_id
      t.integer :utilizer_address_id
      t.integer :land_id
      t.integer :location_id
      t.integer :appearance
      t.integer :rooms
      t.integer :floors
      t.float :width
      t.float :length
      t.integer :utilization
      t.text :comment
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :buildings
  end
end
