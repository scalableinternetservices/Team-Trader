class AddUserToInvestment < ActiveRecord::Migration
  def change
    add_reference :investments, :user, index: true
  end
end
