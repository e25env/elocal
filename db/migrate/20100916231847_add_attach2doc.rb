class AddAttach2doc < ActiveRecord::Migration
  def self.up
    add_column :docs, :attach, :string
  end

  def self.down
    add_column :docs, :attach
  end
end
