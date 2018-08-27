class AddRemainAmountToExpense < ActiveRecord::Migration
  def change
  	add_column :expenses, :remain_amount, :integer, default: 0
  end
end
