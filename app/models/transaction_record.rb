class TransactionRecord < ActiveRecord::Base
  belongs_to :process, polymorphic: true, :dependent => :destroy
  belongs_to :user
end
