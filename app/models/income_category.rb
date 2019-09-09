class IncomeCategory < ApplicationRecord
  has_many :incomes
  belongs_to :user
end
