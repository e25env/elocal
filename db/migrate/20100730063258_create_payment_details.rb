class CreatePaymentDetails < ActiveRecord::Migration
  def self.up
    create_table :payment_details do |t|
      t.integer :payment_id
      t.string :doc
      t.string :item
      t.float :amount
      t.float :deduct
      t.float :gsb
      t.string :comment
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :payment_details
  end
end
