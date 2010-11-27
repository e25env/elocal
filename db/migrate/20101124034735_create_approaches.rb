class CreateApproaches < ActiveRecord::Migration
  def self.up
    create_table :approaches, :force=>true do |t|
      t.text :name
      t.integer :strategy_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :approaches
  end
end
