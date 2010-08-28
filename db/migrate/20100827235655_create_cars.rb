class CreateCars < ActiveRecord::Migration
  def self.up
    create_table :cars, :force=>true do |t|
      t.string :brand
      t.string :color
      t.string :car_code
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :cars
  end
end
