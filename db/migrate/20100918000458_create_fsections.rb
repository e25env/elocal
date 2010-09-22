class CreateFsections < ActiveRecord::Migration
  def self.up
    create_table :fsections, :force=>true do |t|
      t.string :code
      t.string :name
      t.string :account
      t.float :budget
      t.float :balance
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :fsections
  end
end
