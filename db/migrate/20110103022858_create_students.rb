class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students, :force=>true do |t|
      t.string :code
      t.integer :person_id
      t.string :fname
      t.integer :address_id
      t.integer :address_reg_id
      t.string :phone
      t.string :cell_phone
      t.integer :father_id
      t.string :father_lname
      t.integer :mother_id
      t.integer :guardian_id
      t.string :relationship
      t.integer :parent_status
      t.string :comment
      t.integer :resident_type
      t.integer :income
      t.string :next_school
      t.string :illness
      t.string :blood_type
      t.string :clinic
      t.text :caution
      t.text :allergy
      t.text :other_nursery
      t.date :accepted_on
      t.date :acquitted_on
      t.text :reason
      t.integer :status
      t.integer :nursery_id
      t.string :application_form
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
