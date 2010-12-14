class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses, :force=>true do |t|
      t.string :address
      t.string :street
      t.integer :moo
      t.integer :sub_district_id
      t.integer :district_id
      t.integer :province_id
      t.integer :address_type
      t.string :doc
      t.float :latitude
      t.float :longitude
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
