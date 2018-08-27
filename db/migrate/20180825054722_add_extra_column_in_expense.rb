class AddExtraColumnInExpense < ActiveRecord::Migration
  def change
  	add_column :expenses, :refundable , :string
  	add_column :expenses, :removed, :string, default: 'NO'
  end
end
