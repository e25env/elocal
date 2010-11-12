class CreateDistricts < ActiveRecord::Migration
  def self.up
    create_table :districts, :force=>true do |t|
      t.string :code
      t.string :name
      t.string :prefix
      t.float :latitude
      t.float :longitude
      t.integer :province_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :districts
  end
end
