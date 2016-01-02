class CreateTransactionRecords < ActiveRecord::Migration
  def change
    create_table :transaction_records do |t|
      t.string :record_name
      t.belongs_to :user
      t.references :process, polymorphic: true
      t.timestamps null: false
    end
  end
end
