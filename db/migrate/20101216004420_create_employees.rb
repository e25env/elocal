class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees, :force=>true do |t|
      t.string :code
      t.integer :person_id
      t.string :position
      t.date :position_on
      t.integer :section_id
      t.integer :level
      t.float :salary
      t.string :appointed_by
      t.string :position_code
      t.integer :address_id
      t.integer :address_reg_id
      t.date :begin_gov_service_on
      t.date :retired_on
      t.integer :spouse_id
      t.integer :father_id
      t.integer :mother_id
      t.integer :address_relative_id
      t.text :skill
      t.integer :highest_education_id
      t.string :blood_type
      t.integer :status
      t.string :photo
      t.date :taken_on
      t.string :signature
      t.float :leave_balance
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
