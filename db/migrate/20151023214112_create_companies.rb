class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :code
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :code, :name

  end

  def self.down
    drop_table :companies
  end
end
