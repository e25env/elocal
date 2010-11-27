class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees, :force=>true do |t|
      t.string :code
      t.string :title
      t.string :fname
      t.string :lname
      t.date :dob
      t.string :nid
      t.string :position
      t.date :position_on
      t.integer :level
      t.float :salary
      t.string :appointed_by
      t.string :position_code
      t.integer :section_id
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
      t.date :begin_gov_service_on
      t.date :retired_on
      t.string :phone
      t.string :cell_phone
      t.string :spouse_title
      t.string :spouse_fname
      t.string :spouse_lname
      t.string :spouse_work
      t.string :father_fname
      t.string :father_lname
      t.string :mother_title
      t.string :mother_fname
      t.string :mother_lname
      t.string :parent_address
      t.string :parent_moo
      t.integer :parent_sub_district_id
      t.integer :parent_district_id
      t.integer :parent_province_id
      t.string :parent_phone
      t.text :skill
      t.integer :highest_education_id
      t.string :blood_type
      t.integer :status
      t.string :photo
      t.date :taken_on
      t.string :signature
      t.integer :leave_sick
      t.integer :leave_vacation
      t.integer :late
      t.integer :missing
      t.integer :leave_study
      t.integer :manpower_id
      t.string :manpower_code
      t.string :comment
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :employees
  end
end
