class CreateTransaktions < ActiveRecord::Migration
  def change
    create_table :transaktions do |t|
      t.decimal :amount
      t.string :description
      t.integer :transaktion_type
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
