class CreateEducations < ActiveRecord::Migration
  def self.up
    create_table :educations, :force=>true do |t|
      t.string :school
      t.integer :education_level_id
      t.string :major
      t.date :edu_begin
      t.date :edu_end
      t.integer :employee_id
      t.string :ref_file
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :educations
  end
end
