class CreateBudgets < ActiveRecord::Migration
  def self.up
    create_table :budgets, :force=>true do |t|
      t.string :code
      t.string :name
      t.string :code_laas
      t.string :account_number
      t.integer :fy
      t.float :budget
      t.float :balance
      t.integer :fsection_id
      t.integer :cat_id
      t.integer :ptype_id
      t.integer :plan_id
      t.integer :task_id
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
