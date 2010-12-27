class CreateMgroups < ActiveRecord::Migration
  def self.up
    create_table :mgroups, :force=>true do |t|
      t.string :name
      t.boolean :shared
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :mgroups
  end
end
