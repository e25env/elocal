class CreateLeaves < ActiveRecord::Migration
  def self.up
    create_table :leaves, :force=>true do |t|
      t.integer :leave_type
      t.date :leave_begin
      t.date :leave_end
      t.float :total_days_this_period
      t.float :total_days_next_period
      t.string :ref_file
      t.integer :employee_id
      t.date :reported_on
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :leaves
  end
end
