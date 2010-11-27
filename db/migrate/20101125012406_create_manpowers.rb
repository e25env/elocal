class CreateManpowers < ActiveRecord::Migration
  def self.up
    create_table :manpowers, :force=>true do |t|
      t.integer :code
      t.integer :name
      t.integer :qualification
      t.integer :status
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :manpowers
  end
end
