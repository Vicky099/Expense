class TransactionRecord < ActiveRecord::Base
  belongs_to :process, polymorphic: true
  belongs_to :user
end
