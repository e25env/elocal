class CreateConstructionDetails < ActiveRecord::Migration
  def self.up
    create_table :construction_details, :force=>true do |t|
      t.integer :building_type
      t.integer :floors
      t.integer :qty
      t.integer :purpose
      t.integer :parking
      t.integer :utilized_area
      t.integer :construction_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :construction_details
  end
end
