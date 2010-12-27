class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages, :force=>true do |t|
      t.integer :inbox_id
      t.integer :outbox_id
      t.integer :mcontent_id
      t.boolean :draft
      t.boolean :read
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
