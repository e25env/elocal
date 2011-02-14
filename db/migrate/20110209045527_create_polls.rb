class CreatePolls < ActiveRecord::Migration
  def self.up
    create_table :polls, :force=>true do |t|
      t.string :name
      t.integer :scope
      t.integer :moo
      t.date :start_on
      t.date :stop_on
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :polls
  end
end
