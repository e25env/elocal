class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses, :force=>true do |t|
      t.string :code
      t.integer :head_person_id
      t.string :address
      t.string :soi
      t.string :street
      t.integer :moo
      t.integer :sub_district_id
      t.integer :district_id
      t.integer :province_id
      t.string :phone
      t.integer :address_type
      t.string :doc
      t.float :lat
      t.float :lng
      t.integer :poll_zone_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
