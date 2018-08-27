module TransactionRecordsHelper

	def type_of_money(process)
    if process.class.name == "Income"
    	return process.amount_type.titleize
    else
    	if process.refundable?
    		if process.remain_amount == 0.0
    			return 'Refund Done'
    		elsif process.remain_amount > 0.0
    			return "Refund Pending - Rs. #{process.remain_amount}"
    		end
      else
      	return 'Direct'
      end
    end
  end

end
