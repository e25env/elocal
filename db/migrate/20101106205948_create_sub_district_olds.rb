class CreateSubDistrictOlds < ActiveRecord::Migration
  def self.up
    create_table :sub_district_olds do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :sub_district_olds
  end
end
