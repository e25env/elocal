class AddRoleToGmaService < ActiveRecord::Migration
  def self.up
    create_table "gma_services", :force => true do |t|
      t.string   "module"
      t.string   "code"
      t.text     "name"
      t.integer  "gma_module_id"
      t.text     "xml"
      t.string   "auth"
      t.string   "role"
      t.string   "rule"
      t.integer  "seq"
      t.boolean  "listed"
      t.boolean  "secured"
      t.integer  "gma_user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
  end
end
