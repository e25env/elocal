class CreateLeaves < ActiveRecord::Migration
  def self.up
    create_table :leaves, :force=>true do |t|
      t.date :filed_on
      t.integer :leave_type
      t.date :leave_begin
      t.date :leave_end
      t.integer :total_days
      t.string :ref_file
      t.integer :employee_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :leaves
  end
end
