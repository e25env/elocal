class RenameXmain < ActiveRecord::Migration
  def self.up
    rename_column :comments, :xmain_id, :gma_xmain_id
  end

  def self.down
  end
end
