class CreateLeaveSummaries < ActiveRecord::Migration
  def self.up
    create_table :leave_summaries, :force=>true do |t|
      t.date :reported_on
      t.float :leave1, :default => 0
      t.float :leave2, :default => 0
      t.float :leave3, :default => 0
      t.float :leave4, :default => 0
      t.float :leave5, :default => 0
      t.float :leave6, :default => 0
      t.float :leave7, :default => 0
      t.float :leave8, :default => 0
      t.float :leave9, :default => 0
      t.float :leave10, :default => 0
      t.float :leave11, :default => 0
      t.integer :employee_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :leave_summaries
  end
end
