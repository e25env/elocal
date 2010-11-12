class CreateStudentRecords < ActiveRecord::Migration
  def self.up
    create_table :student_records, :force=>true do |t|
      t.date :recorded_on
      t.float :weight
      t.float :height
      t.float :head_length
      t.integer :student_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :student_records
  end
end
