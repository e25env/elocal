class CreatePollSelections < ActiveRecord::Migration
  def self.up
    create_table :poll_selections, :force=>true do |t|
      t.string :code
      t.string :name
      t.string :color
      t.integer :poll_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :poll_selections
  end
end
