class AddExtraFieldsToIncome < ActiveRecord::Migration
  def change
  	add_column :incomes, :amount_type, :string, default: '0'
  	add_column :incomes, :expense_id, :integer, index: true
  	add_column :incomes, :refund_type, :string
  end
end
