class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts, :force=>true do |t|
      t.string :code
      t.string :code_dla
      t.string :name
      t.integer :atype
      t.float :balance
      t.integer :parent_id
      t.boolean :reported
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
