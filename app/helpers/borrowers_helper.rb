module BorrowersHelper

	def remain_amount(borrower)
		return borrower.borrower_records.pluck(:remain_amount).sum
	end
end
