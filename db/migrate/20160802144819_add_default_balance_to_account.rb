class AddDefaultBalanceToAccount < ActiveRecord::Migration
  def change
    change_column :accounts, :balance, :decimal, :default => 0.00
  end
end
