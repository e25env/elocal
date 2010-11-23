class CreateDiscussions < ActiveRecord::Migration
  def self.up
    create_table :discussions, :force=>true do |t|
      t.text :post
      t.string :attach_file
      t.boolean :photo
      t.integer :project_id
      t.integer :discussion_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :discussions
  end
end
