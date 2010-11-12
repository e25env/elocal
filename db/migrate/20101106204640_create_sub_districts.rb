class CreateSubDistricts < ActiveRecord::Migration
  def self.up
    create_table :sub_districts, :force=>true do |t|
      t.string :code
      t.string :name
      t.integer :district_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sub_districts
  end
end
