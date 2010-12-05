class AddSecuredToGmaDoc < ActiveRecord::Migration
  def self.up
    add_column :gma_docs, :secured, :boolean, :default=> false
    GmaDoc.update_all :secured => false
  end

  def self.down
    remove_column(:gma_docs, :secured)
  end
end
