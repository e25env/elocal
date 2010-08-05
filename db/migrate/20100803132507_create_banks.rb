class CreateBanks < ActiveRecord::Migration
  def self.up
    create_table :banks do |t|
      t.string :code
      t.string :name
      t.string :account
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :banks
  end
end
