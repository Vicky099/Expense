class Income < ActiveRecord::Base
  belongs_to :user
  belongs_to :income_category
  has_one :transaction_record, as: :process, :dependent => :destroy
  accepts_nested_attributes_for :transaction_record

 	validates :amount, presence: true
 	validates :income_category_id, presence: true
 	validates :date, presence: true
 	validates :description, presence: true
 	validates :user_id, presence: true
end
