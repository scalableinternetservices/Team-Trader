class CreateIndices < ActiveRecord::Migration
  def change
    create_table :indices do |t|
      t.string :symbol
      t.string :name
      t.string :market_cap
      t.string :ipo_year
      t.string :sector
      t.string :industry
      t.string :link
      t.string :exchange

      t.timestamps null: false
    end
    add_index :indices, :symbol
  end
end
