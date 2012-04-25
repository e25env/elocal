class CreateSeniors < ActiveRecord::Migration
  def self.up
    create_table :seniors, :force=>true do |t|
      t.string :title
      t.string :fname
      t.string :lname
      t.string :nid
      t.string :doc_id
      t.string :doc_house
      t.date :dob
      t.string :phone
      t.string :address
      t.string :street
      t.integer :moo
      t.integer :sub_district_id
      t.integer :district_id
      t.integer :province_id
      t.integer :status
      t.integer :budget
      t.integer :underprivileged
      t.string :ref_in
      t.string :ref_out
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :seniors
  end
end
