class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students, :force=>true do |t|
      t.string :code
      t.string :title
      t.string :fname
      t.string :lname
      t.date :dob
      t.string :nid
      t.string :address
      t.string :moo
      t.integer :sub_district_id
      t.integer :district_id
      t.integer :province_id
      t.string :address_reg
      t.string :moo_reg
      t.integer :sub_district_reg_id
      t.integer :district_reg_id
      t.integer :province_reg_id
      t.string :phone
      t.string :cell_phone
      t.string :father_fname
      t.string :father_lname
      t.string :father_job
      t.string :mother_title
      t.string :mother_fname
      t.string :mother_lname
      t.string :mother_job
      t.string :guardian_title
      t.string :guardian_fname
      t.string :guardian_lname
      t.string :guardian_job
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
