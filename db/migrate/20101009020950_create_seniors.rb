class CreateSeniors < ActiveRecord::Migration
  def self.up
    create_table :seniors, :force=>true do |t|
      t.string :title
      t.string :fname
      t.string :lname
      t.string :address
      t.integer :moo
      t.integer :nid
      t.date :dob
      t.boolean :year_only
      t.integer :yob
      t.integer :status
      t.integer :budget
      t.date :dod
      t.string :phone
      t.string :ref
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :seniors
  end
end
