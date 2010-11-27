class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs, :force=>true do |t|
      t.date :effective_on
      t.string :name
      t.text :description
      t.integer :level
      t.float :salary
      t.string :authorized_by
      t.string :authorized_position
      t.string :ref
      t.string :ref_file
      t.integer :employee_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
