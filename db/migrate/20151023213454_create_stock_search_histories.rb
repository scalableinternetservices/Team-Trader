class CreateStockSearchHistories < ActiveRecord::Migration
  def change
    create_table :stock_search_histories do |t|
      t.string :stock
      t.integer :count

      t.timestamps null: false
    end
  end
end
