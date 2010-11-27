class CreateEmployeePhotos < ActiveRecord::Migration
  def self.up
    create_table :employee_photos, :force=>true do |t|
      t.date :taken_on
      t.string :photo
      t.integer :employee_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :employee_photos
  end
end
