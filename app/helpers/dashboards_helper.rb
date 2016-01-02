module DashboardsHelper
  
  def total_balance(user)
     total_balance = 0
     return total_balance = total_income(user) - total_expense(user) 
  end
  
  def total_expense(user)
    total_expense = 0
    expense = user.expenses
    expense.each do |user_expense|
      total_expense = total_expense + user_expense.amount
    end
    return total_expense
  end
  
  def total_income(user)
    total_income = 0
    income = user.incomes
    income.each do |user_income|
      total_income = total_income + user_income.amount
    end
    return total_income
  end
  
end
