class CreateSeniors < ActiveRecord::Migration
  def self.up
    create_table :seniors, :force=>true do |t|
      t.integer :person_id
      t.integer :address_id
      t.integer :status
      t.integer :budget
      t.integer :underprivileged
      t.string :ref_in
      t.string :ref_out
      t.integer :moo
      t.string :fname
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :seniors
  end
end
