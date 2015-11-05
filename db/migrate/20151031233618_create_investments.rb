class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.string :stockName
      t.string :ticker
      t.integer :quantity
      t.float :buyingPrice
      t.date :buyingDate

      t.timestamps null: false
    end
  end
end
