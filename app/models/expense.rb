class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :expense_category
  has_one :transaction_record, as: :process
  accepts_nested_attributes_for :transaction_record
end
