class ChangeDefaultPayment < ActiveRecord::Migration
  def self.up
    change_column_default(:payments, :amount, 0)
    change_column_default(:payments, :vat, 0)
    change_column_default(:payments, :total, 0)
    change_column_default(:payments, :deduct, 0)
    change_column_default(:payments, :gsb, 0)
    change_column_default(:payments, :net_amount, 0)
    change_column_default(:payments, :total_budget, 0)
    change_column_default(:payments, :budget, 0)
    change_column_default(:payments, :net_budget, 0)
  end

  def self.down
    change_column_default(:payments, :amount, nil)
    change_column_default(:payments, :vat, nil)
    change_column_default(:payments, :total, nil)
    change_column_default(:payments, :deduct, nil)
    change_column_default(:payments, :gsb, nil)
    change_column_default(:payments, :net_amount, nil)
    change_column_default(:payments, :total_budget, nil)
    change_column_default(:payments, :budget, nil)
    change_column_default(:payments, :net_budget, nil)
  end
end
