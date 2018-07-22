class AddFieldsToIncome < ActiveRecord::Migration
  def change
  	add_column :incomes, :description, :string
  end
end
