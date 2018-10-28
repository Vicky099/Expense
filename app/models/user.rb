class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :incomes
  has_many :income_categories
  has_many :expenses
  has_many :expense_categories
  has_many :transaction_records
  has_many :borrowers
end
