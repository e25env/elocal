class CreateLaasQueues < ActiveRecord::Migration
  def self.up
    create_table :laas_queues, :force=>true do |t|
      t.integer :xmain_id
      t.string :name
      t.text :description
      t.text :script
      t.string :confirm
      t.integer :status
      t.datetime :submitted_at
      t.integer :retry
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :laas_queues
  end
end
