class CreateIncomeCategories < ActiveRecord::Migration
  def change
    create_table :income_categories do |t|
      t.belongs_to :user
      t.string :income_source
      t.string :description
      t.timestamps
    end
  end
end
