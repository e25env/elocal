class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table :payments, :force=>true do |t|
      t.integer :org_id
      t.integer :section_id
      t.integer :subsection_id
      t.integer :num
      t.integer :finance_num
      t.integer :plan_id
      t.integer :task_id
      t.integer :fy
      t.date :receive_on
      t.integer :cat_id
      t.integer :ptype_id
      t.integer :budget_id
      t.integer :law_page
      t.string :law_item
      t.string :law_moi_item
      t.integer :law_moi_year
      t.float :amount
      t.float :vat
      t.float :total
      t.float :deduct
      t.float :gsb
      t.float :net_amount
      t.text :comment
      t.float :total_budget
      t.float :budget_before
      t.float :net_budget
      t.integer :bank_id
      t.string :check_num
      t.date :check_issue_on
      t.string :payable
      t.string :dscan
      t.integer :requester_id
      t.string :requester_position
      t.integer :budgeter_id
      t.string :budgeter_position
      t.integer :inspector_id
      t.string :inspector_position
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
