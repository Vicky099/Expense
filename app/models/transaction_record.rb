class TransactionRecord < ApplicationRecord
  belongs_to :process, polymorphic: true, :dependent => :destroy
  belongs_to :user
end
