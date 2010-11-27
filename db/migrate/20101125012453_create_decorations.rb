class CreateDecorations < ActiveRecord::Migration
  def self.up
    create_table :decorations, :force=>true do |t|
      t.integer :employee_id
      t.string :name
      t.date :received_on
      t.date :returned_on
      t.string :ref
      t.string :ref_file
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :decorations
  end
end
