module DashboardsHelper

  def total_balance(user)
    return total_income(user) - total_expense(user)
  end

  def total_expense(user)
    return total_pending_refund(user) + user.expenses.where('refundable=?','NO').pluck(:amount).sum
  end

  def total_income(user)
    return user.incomes.where('amount_type=?',Income.amount_types['direct']).pluck(:amount).sum
  end

  def total_pending_refund(user)
    return user.expenses.where('refundable=?','YES').pluck(:remain_amount).sum
  end

  def total_borrowers_count(user)
    return user.borrowers.count
  end
end
