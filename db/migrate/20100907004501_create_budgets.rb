class CreateBudgets < ActiveRecord::Migration
  def self.up
    create_table :budgets, :force=>true do |t|
      t.integer :section_id
      t.integer :ptype_id
      t.integer :task_id
      t.string :code
      t.string :name
      t.string :code_laas
      t.string :account_number
      t.float :budget
      t.float :balance
      t.integer :fy
      t.integer :law_page
      t.string :law_item
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :budgets
  end
end
