class AddCodeLaas < ActiveRecord::Migration
  def self.up
    add_column :cats, :code_laas, :string
    add_column :ptypes, :code_laas, :string
    add_column :plans, :code_laas, :string
    add_column :tasks, :code_laas, :string
  end

  def self.down
    remove_column :cats, :code_laas
    remove_column :ptypes, :code_laas
    remove_column :plans, :code_laas
    remove_column :tasks, :code_laas
  end
end
