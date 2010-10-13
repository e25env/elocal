class CreateVillageHeads < ActiveRecord::Migration
  def self.up
    create_table :village_heads, :force=>true do |t|
      t.string :title
      t.string :fname
      t.string :lname
      t.integer :moo
      t.string :address
      t.string :sub_district
      t.string :district
      t.string :province
      t.string :phone
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :village_heads
  end
end
