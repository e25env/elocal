class CreateBanks < ActiveRecord::Migration
  def self.up
    create_table :banks, :force=>true do |t|
      t.string :code
      t.string :name
      t.string :branch
      t.string :account
      t.integer :atype
      t.float :balance, :default=>0.0
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :banks
  end
end
