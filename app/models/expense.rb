class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :expense_category
  has_one :transaction_record, as: :process, :dependent => :destroy
  accepts_nested_attributes_for :transaction_record

  validates :amount, presence: true
  validates :user_id, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :expense_category_id, presence: true

  def is_refund_done
  	return self.refundable.to_s == 'YES' && self.remain_amount.to_f == 0.0
  end

  def self.refundable_records
  	return Expense.where('refundable=?', 'YES')
  end

  def self.non_refundable_records
  	return Expense.where('refundable=?','NO')
  end

  def refundable?
  	return self.refundable == "YES"
  end

  def income_records
  	return Income.where('expense_id=? and user_id=?',self.id, self.user_id)
  end
end
