class CreateCars < ActiveRecord::Migration
  def self.up
    create_table :cars do |t|
      t.string :name
      t.string :position
      t.string :destination
      t.string :objective
      t.integer :passenger
      t.datetime :schedule_at
      t.integer :km_begin
      t.integer :km_end
      t.string :car_code
      t.integer :vtype
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cars
  end
end
