class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.string :string
      t.float :price
      t.date :date

      t.timestamps null: false
    end
  end
end
