class CreateEducations < ActiveRecord::Migration
  def self.up
    create_table :educations, :force=>true do |t|
      t.string :name
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :educations
  end
end
