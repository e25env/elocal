class CreateAccountTrans < ActiveRecord::Migration
  def self.up
    create_table :account_trans, :force=>true do |t|
      t.integer :account_id
      t.string :description
      t.date :reported_on
      t.integer :rtype
      t.float :amount
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :account_trans
  end
end
