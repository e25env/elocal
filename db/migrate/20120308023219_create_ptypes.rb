class CreatePtypes < ActiveRecord::Migration
  def self.up
    create_table :ptypes, :force=>true do |t|
      t.integer :cat_id
      t.string :code
      t.string :name
      t.string :code_laas
      t.string :account_number
      t.integer :law_page
      t.string :law_item
      t.integer :fy
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ptypes
  end
end
