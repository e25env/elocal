class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people, :force=>true do |t|
      t.string :title
      t.string :fname
      t.string :lname
      t.integer :address_id
      t.string :nid
      t.string :doc
      t.date :dob
      t.boolean :year_only
      t.integer :yob
      t.date :dod
      t.string :phone
      t.string :cell_phone
      t.string :work
      t.string :photo
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
