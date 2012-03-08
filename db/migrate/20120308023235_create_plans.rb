class CreatePlans < ActiveRecord::Migration
  def self.up
    create_table :plans, :force=>true do |t|
      t.string :code
      t.string :code_laas
      t.string :name
      t.integer :side_id
      t.integer :fy
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :plans
  end
end
