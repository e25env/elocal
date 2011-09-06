class AddStarterToGmaModule < ActiveRecord::Migration
  def self.up
    add_column :gma_modules, :starter, :boolean
  end

  def self.down
    remove_column :gma_modules, :starter
  end
end
