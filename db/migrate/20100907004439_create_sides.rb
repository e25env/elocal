class CreateSides < ActiveRecord::Migration
  def self.up
    create_table :sides, :force=>true do |t|
      t.string :code
      t.string :name
      t.float :budget, :default=>0
      t.float :balance, :default=>0
      t.integer :gma_user_id

      t.timestamps
    end
    Side.create :name=>"บริหารทั่วไป"
    Side.create :name=>"บริการชุมชนและสังคม"
    Side.create :name=>"เศรษฐกิจ"
    Side.create :name=>"การดำเนินงานอื่น"
  end

  def self.down
    drop_table :sides
  end
end
