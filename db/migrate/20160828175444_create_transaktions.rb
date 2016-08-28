class CreateTransaktions < ActiveRecord::Migration
  def change
    create_table :transaktions do |t|
      t.string :description
      t.decimal :amount
      t.integer :transaktion_type
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
