class CreateVisions < ActiveRecord::Migration
  def self.up
    create_table :visions, :force=>true do |t|
      t.text :vision
      t.text :mission
      t.text :goal
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :visions
  end
end
