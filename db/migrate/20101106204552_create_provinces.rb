class CreateProvinces < ActiveRecord::Migration
  def self.up
    create_table :provinces, :force=>true do |t|
      t.string :code
      t.string :name
      t.integer :region
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :provinces
  end
end
