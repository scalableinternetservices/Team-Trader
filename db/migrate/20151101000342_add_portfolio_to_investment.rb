class AddPortfolioToInvestment < ActiveRecord::Migration
  def change
    add_reference :investments, :portfolio, index: true
  end
end
