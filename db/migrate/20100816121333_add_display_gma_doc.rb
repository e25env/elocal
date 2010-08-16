class AddDisplayGmaDoc < ActiveRecord::Migration
  def self.up
    add_column :gma_docs, :display, :boolean
  end

  def self.down
    remove_column :gma_docs, :display
  end
end
