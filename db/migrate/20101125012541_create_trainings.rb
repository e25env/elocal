class CreateTrainings < ActiveRecord::Migration
  def self.up
    create_table :trainings, :force=>true do |t|
      t.string :name
      t.string :certificate
      t.date :train_begin
      t.date :train_end
      t.integer :employee_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :trainings
  end
end
