class CreateEducationLevels < ActiveRecord::Migration
  def self.up
    create_table :education_levels, :force=>true do |t|
      t.string :name
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :education_levels
  end
end
