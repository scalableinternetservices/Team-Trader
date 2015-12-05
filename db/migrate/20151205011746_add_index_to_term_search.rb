class AddIndexToTermSearch < ActiveRecord::Migration
  def change
     add_index :term_search_histories, :count
     add_index :term_search_histories, :term, :unique => true
  end
end
