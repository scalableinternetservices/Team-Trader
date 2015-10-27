class CreateTermSearchHistories < ActiveRecord::Migration
  def change
    create_table :term_search_histories do |t|
      t.string :term
      t.integer :count

      t.timestamps null: false
    end
  end
end
