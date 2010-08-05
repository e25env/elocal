class AddLawPtype < ActiveRecord::Migration
  def self.up
    add_column :ptypes, :law_page, :integer
    add_column :ptypes, :law_item, :string
    add_column :payments, :law_moi_year, :integer
  end

  def self.down
    remove_column(:ptypes, :law_page)
    remove_column(:ptypes, :law_item)
    remove_column(:payments, :law_moi_year)
  end
end
