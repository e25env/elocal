class CreateSigns < ActiveRecord::Migration
  def self.up
    create_table :signs, :force=>true do |t|
      t.integer :location_id
      t.integer :owner_id
      t.integer :sign_type
      t.float :width
      t.float :length
      t.float :area
      t.integer :sides
      t.string :message
      t.text :comment
      t.float :tax
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :signs
  end
end
