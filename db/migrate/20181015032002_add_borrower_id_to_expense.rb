class AddBorrowerIdToExpense < ActiveRecord::Migration
  def change
  	add_reference :expenses, :borrower, index: true
  end
end
