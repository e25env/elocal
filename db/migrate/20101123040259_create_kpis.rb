class CreateKpis < ActiveRecord::Migration
  def self.up
    create_table :kpis, :force=>true do |t|
      t.string :name
      t.text :description
      t.text :formula
      t.string :unit
      t.integer :score
      t.integer :weight
      t.float :s2
      t.float :s3
      t.float :s4
      t.float :s5
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :kpis
  end
end
