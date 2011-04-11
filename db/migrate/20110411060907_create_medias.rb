class CreateMedias < ActiveRecord::Migration
  def self.up
    create_table :medias, :force=>true do |t|
      t.integer :post_id
      t.string :file_name
      t.string :content_type
      t.integer :size
      t.string :url
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :medias
  end
end
