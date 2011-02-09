class CreateLands < ActiveRecord::Migration
  def self.up
    create_table :lands, :force=>true do |t|
      t.integer :owner_id
      t.integer :owner_address_id
      t.string :pt4_code
      t.string :land_code
      t.integer :location_id
      t.integer :doc_type
      t.string :doc_num
      t.integer :location_plan
      t.integer :location_num
      t.integer :location_survey
      t.integer :area_rai
      t.integer :area_ngan
      t.integer :area_wa
      t.integer :area_sqm
      t.string :usage
      t.string :utilize
      t.integer :utilizer_id
      t.integer :utilizer_address_id
      t.text :comment
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lands
  end
end
