module ExpensesHelper

	def is_refunded(expense)
		incomes = Income.where(expense_id: expense.id)
		refunded = false
		if incomes.present?
			incomes.each do |income|
				if Income.refund_types[income.refund_type] == Income.refund_types['full']
					refunded = true
					break
				end
			end
		end
		return refunded
	end

	def refund_status(expense)
		if expense.refundable?
			if is_refunded(expense)
				return "Refund done"
			else
				return "Refund pending"
			end
		else
			return 'Direct'
		end
	end
end
