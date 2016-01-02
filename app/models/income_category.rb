class IncomeCategory < ActiveRecord::Base
  has_many :incomes
  belongs_to :user
end
