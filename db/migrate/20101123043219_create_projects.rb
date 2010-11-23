class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects, :force=>true do |t|
      t.text :name
      t.text :objective
      t.float :budget
      t.string :moo
      t.string :contract
      t.boolean :coordinated
      t.integer :strategy_id
      t.integer :method_id
      t.integer :section_id
      t.integer :project_type_id
      t.integer :activity_id
      t.integer :supplier_id
      t.integer :fy
      t.integer :score
      t.integer :weight
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
