class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :code
      t.string :name
      t.string :doc_code
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
