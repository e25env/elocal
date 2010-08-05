class AddDscanPayment < ActiveRecord::Migration
  def self.up
    add_column :payments, :dscan, :string
    remove_column(:payments, :org_id)
    remove_column(:payments, :subsection_id)
    remove_column(:payments, :law_page)
    remove_column(:payments, :law_item)
  end

  def self.down
    remove_column(:payments, :dscan)
  end
end
