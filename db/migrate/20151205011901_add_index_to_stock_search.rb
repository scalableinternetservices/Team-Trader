class AddIndexToStockSearch < ActiveRecord::Migration
  def change
    add_index :stock_search_histories, :count
    add_index :stock_search_histories, :stock, :unique => true
  end
end
