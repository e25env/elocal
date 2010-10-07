class CreateIncomeDetails < ActiveRecord::Migration
  def self.up
    create_table :income_details, :force=>true do |t|
      t.integer :income_id
      t.string :receipt
      t.string :description
      t.integer :task_id
      t.float :amount
      t.integer :num_receipt
      t.string :remark
      t.integer :rcat_id
      t.integer :rtype_id
      t.integer :revenue_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :income_details
  end
end
