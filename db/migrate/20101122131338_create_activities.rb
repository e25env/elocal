class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities, :force=>true do |t|
      t.text :name
      t.integer :project_type_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
