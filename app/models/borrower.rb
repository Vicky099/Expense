class Borrower < ApplicationRecord
	has_many :borrower_records, foreign_key: "borrower_id", class_name: "Expense"
	belongs_to :user

	validates :name, presence: true
	validates :relation_with_payer, presence: true
	validates	:contact_num, presence: true, uniqueness: true, numericality: true
end
