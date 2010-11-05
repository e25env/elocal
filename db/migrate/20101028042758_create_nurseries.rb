class CreateNurseries < ActiveRecord::Migration
  def self.up
    create_table :nurseries, :force=>true do |t|
      t.string :code
      t.string :name
      t.string :phone
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :nurseries
  end
end
