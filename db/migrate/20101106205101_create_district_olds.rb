class CreateDistrictOlds < ActiveRecord::Migration
  def self.up
    create_table :district_olds do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :district_olds
  end
end
