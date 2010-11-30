class CreateLeaveSummaries < ActiveRecord::Migration
  def self.up
    create_table :leave_summaries, :force=>true do |t|
      t.date :reported_on
      t.float :sick
      t.float :vacation
      t.integer :late
      t.integer :missing
      t.float :education
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :leave_summaries
  end
end
