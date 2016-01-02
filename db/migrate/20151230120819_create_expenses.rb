class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :amount, :default => 0
      t.belongs_to :user
      t.belongs_to :expense_category
      t.date :date
      t.timestamps
    end
  end
end
