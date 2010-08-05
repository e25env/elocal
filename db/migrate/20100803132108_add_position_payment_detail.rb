class AddPositionPaymentDetail < ActiveRecord::Migration
  def self.up
    rename_column(:payment_details, :item, :name)
    add_column :payment_details, :position, :string
  end

  def self.down
    rename_column(:payment_details, :name, :item)
    remove_column(:payment_details, :position)
  end
end
