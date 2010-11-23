class CreatePerformances < ActiveRecord::Migration
  def self.up
    create_table :performances, :force=>true do |t|
      t.integer :project_id
      t.integer :strategy_id
      t.integer :kpi_id
      t.float :target
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :performances
  end
end
