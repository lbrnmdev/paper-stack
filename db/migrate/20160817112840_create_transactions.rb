class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :description
      t.decimal :amount
      t.integer :type
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
