class Income < ApplicationRecord
  belongs_to :user
  belongs_to :income_category
  has_one :transaction_record, as: :process, :dependent => :destroy
  accepts_nested_attributes_for :transaction_record

 	validates :amount, presence: true, numericality: true
 	validates :income_category_id, presence: true
 	validates :date, presence: true
 	validates :description, presence: true
 	validates :user_id, presence: true

 	enum amount_type: {direct: '0', refund: '1'}
 	enum refund_type: {full: '0', partial: '1'}

 	def expense_record
 		return Expense.where('user_id=? and id=?',self.user_id,self.expense_id).first
 	end
end
