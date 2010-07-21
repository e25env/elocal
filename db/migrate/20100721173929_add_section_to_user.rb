class AddSectionToUser < ActiveRecord::Migration
  def self.up
    add_column :gma_users, :section_id, :integer
    add_column :gma_users, :subsection_id, :integer
  end

  def self.down
    remove_column :gma_users, :section_id
    remove_column :gma_users, :subsection_id
  end
end
