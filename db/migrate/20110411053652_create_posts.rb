class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts, :force=>true do |t|
      t.string :subject
      t.text :body
      t.boolean :stick
      t.integer :post_type
      t.date :begin_on
      t.date :end_on
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
