class CreateCats < ActiveRecord::Migration
  def self.up
    create_table :cats, :force=>true do |t|
      t.string :code
      t.string :code_laas
      t.string :name
      t.string :account_number
      t.integer :fy
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cats
  end
end
