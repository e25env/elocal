class CreatePollZones < ActiveRecord::Migration
  def self.up
    create_table :poll_zones, :force=>true do |t|
      t.string :code
      t.integer :moo
      t.integer :user_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :poll_zones
  end
end
