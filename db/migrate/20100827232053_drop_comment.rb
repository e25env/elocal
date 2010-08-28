class DropComment < ActiveRecord::Migration
  def self.up
    drop_table :comments
  end

  def self.down
    create_table :comments do |t|
      t.text :content
      t.integer :xmain_id
      t.integer :gma_user_id

      t.timestamps
    end
  end
end
