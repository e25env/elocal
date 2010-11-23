class CreateKpiDatas < ActiveRecord::Migration
  def self.up
    create_table :kpi_datas, :force=>true do |t|
      t.float :value
      t.date :recorded_on
      t.integer :kpi_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :kpi_datas
  end
end
