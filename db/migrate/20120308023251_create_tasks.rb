class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks, :force=>true do |t|
      t.integer :plan_id
      t.string :code
      t.string :name
      t.string :code_laas
      t.integer :fy
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
