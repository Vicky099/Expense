class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
    	t.string :name
    	t.string :email
    	t.string :contact_num
    	t.string :relation_with_payer
    	t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
