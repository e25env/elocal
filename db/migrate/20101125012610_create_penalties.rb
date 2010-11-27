class CreatePenalties < ActiveRecord::Migration
  def self.up
    create_table :penalties, :force=>true do |t|
      t.date :issued_on
      t.string :summary
      t.text :description
      t.text :sentence
      t.string :ref
      t.string :ref_file
      t.integer :employee_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :penalties
  end
end
