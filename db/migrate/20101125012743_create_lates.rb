class CreateLates < ActiveRecord::Migration
  def self.up
    create_table :lates, :force=>true do |t|
      t.date :reported_on
      t.integer :late_type
      t.integer :total_days
      t.integer :employee_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lates
  end
end
