class CreateStrategies < ActiveRecord::Migration
  def self.up
    create_table :strategies, :force=>true do |t|
      t.text :name
      t.text :description
      t.text :national
      t.text :province
      t.integer :score
      t.integer :weight
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :strategies
  end
end
