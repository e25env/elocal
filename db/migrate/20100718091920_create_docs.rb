class CreateDocs < ActiveRecord::Migration
  def self.up
    create_table :docs do |t|
      t.integer :rnum
      t.string :num
      t.date :issue_on
      t.string :dfrom
      t.string :dto
      t.string :subject
      t.integer :section_id
      t.datetime :process_at
      t.text :summary
      t.string :dscan
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :docs
  end
end
