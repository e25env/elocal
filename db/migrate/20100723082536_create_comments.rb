class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :content
      t.integer :xmain_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
