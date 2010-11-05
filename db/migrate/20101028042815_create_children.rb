class CreateChildren < ActiveRecord::Migration
  def self.up
    create_table :children, :force=>true do |t|
      t.string :title
      t.string :fname
      t.string :lname
      t.date :bod
      t.string :nid
      t.string :address
      t.string :sub_district
      t.string :district
      t.string :province
      t.string :phone
      t.string :father_fname
      t.string :father_lname
      t.string :mother_fname
      t.string :mother_lname
      t.integer :parent_status
      t.string :comment
      t.integer :nusery_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :children
  end
end
