class CreateMcontents < ActiveRecord::Migration
  def self.up
    create_table :mcontents, :force=>true do |t|
      t.integer :sender_id
      t.integer :receiver_type
      t.integer :receiver_id
      t.integer :mgroup_id
      t.string :subject
      t.text :body
      t.string :attachment
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :mcontents
  end
end
