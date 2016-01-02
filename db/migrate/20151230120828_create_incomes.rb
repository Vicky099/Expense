class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.belongs_to :user
      t.belongs_to :income_category
      t.integer :amount, :default => 0
      t.date :date
      t.timestamps
    end
  end
end
