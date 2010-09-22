class CreateRcats < ActiveRecord::Migration
  def self.up
    create_table :rcats, :force=>true do |t|
      t.string :code
      t.string :name
      t.string :code_laas
      t.string :account_number
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :rcats
  end
end
