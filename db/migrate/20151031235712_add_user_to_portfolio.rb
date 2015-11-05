class AddUserToPortfolio < ActiveRecord::Migration
  def change
    add_reference :portfolios, :user, index: true
  end
end
