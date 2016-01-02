class CreateExpenseCategories < ActiveRecord::Migration
  def change
    create_table :expense_categories do |t|
      t.belongs_to :user
      t.string :expense_source
      t.string :description
      t.timestamps
    end
  end
end
