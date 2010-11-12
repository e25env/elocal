class CreateProvinceOlds < ActiveRecord::Migration
  def self.up
    create_table :province_olds do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :province_olds
  end
end
