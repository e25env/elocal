class CreateIncomes < ActiveRecord::Migration
  def self.up
    create_table :incomes, :force=>true do |t|
      t.integer :revenue_id
      t.string :ref
      t.integer :section_id
      t.integer :subsection_id
      t.integer :deliver_id
      t.integer :receiver_id
      t.float :amount
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :incomes
  end
end
