class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.date :date
      t.float :open_price
      t.float :highest_price
      t.float :lowest_price
      t.float :close_price
      t.float :volume
      t.float :adj_close

      t.timestamps null: false
    end
  end
end
