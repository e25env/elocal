class CreateIncomes < ActiveRecord::Migration
  def self.up
    create_table :incomes, :force=>true do |t|
      t.string :ref
      t.integer :deliver_id
      t.integer :receiver_id
      t.integer :fy
      t.date :receive_on
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :incomes
  end
end
