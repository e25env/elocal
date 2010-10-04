class CreateIncomeDetails < ActiveRecord::Migration
  def self.up
    create_table :income_details, :force=>true do |t|
      t.integer :income_id
      t.string :receipt
      t.string :description
      t.integer :task_id
      t.string :account_number
      t.float :amount
      t.string :remark
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :income_details
  end
end
