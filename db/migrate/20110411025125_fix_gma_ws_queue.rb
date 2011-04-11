class FixGmaWsQueue < ActiveRecord::Migration
  def self.up
    drop_table "gma_ws_queues"
    create_table "gma_ws_queues", :force => true do |t|
      t.string   "url"
      t.text     "body"
      t.string   "poll_url"
      t.integer  "wait"
      t.integer  "status"
      t.integer  "gma_runseq_id"
      t.datetime "next_poll_at"
      t.integer  "gma_user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
  end
end
