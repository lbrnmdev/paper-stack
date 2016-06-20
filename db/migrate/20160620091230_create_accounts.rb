class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.decimal :balance
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
