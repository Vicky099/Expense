class ExpensesController < ApplicationController

  before_action :authenticate_user!
  before_action :current_expense_record, only: [:edit, :update, :refund_process, :refund_income_logs]

  def index
    @expenses = current_user.expenses.order('id DESC').paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @expense = current_user.expenses.new
  end

  def create
    @expense = current_user.expenses.new(expense_params)
    @expense.build_transaction_record(user_id: @expense.user_id, record_name: @expense.expense_category.present? ? @expense.expense_category.expense_source : '')
    @expense.remain_amount = @expense.amount.to_i if @expense.refundable?
    if @expense.save
      flash[:success] = "Expenses added successfully."
      redirect_to expenses_path
    else
      flash[:danger] = "Expenses not added successfully."
      render :new
    end
  end

  def edit
  end

  def update
    if @expense.update_attributes(expense_params)
      update_remaining_amount(@expense)
      flash[:success] = "expense updated successfully."
      redirect_to expenses_path
    else
      flash[:danger] = "Error occurred try again."
      render :edit
    end
  end

  def category
   @expense_category = ExpenseCategory.new
  end

  def save_expense_category
    @expense_category = ExpenseCategory.new(expense_category_params)
    if @expense_category.save
      flash[:success] = "Expenses category added successfully. Add one another."
      redirect_to category_expenses_path
    else
      flash[:danger] = "Error occurred try again."
      render :category
    end
  end

  def all_expense_category
    @expense_category = ExpenseCategory.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 15)
  end

  def refund_history
    @refunds = current_user.expenses.where('refundable=?','YES').order('id DESC').paginate(:page => params[:page], :per_page => 15)
  end

  def refund_process
    @income = Income.new
    @refund_category = IncomeCategory.where('income_source=?','Refund').first
  end

  def refund_income_logs
    @refund_incomes = current_user.incomes.where('expense_id=?', params[:id]).order('id DESC').paginate(:page => params[:page], :per_page=>15)
  end

  private

  def expense_params
    params.require(:expense).permit(:amount, :date, :expense_category_id, :user_id, :description, :refundable, :remain_amount, :borrower_id, :_destroy)
  end

  def expense_category_params
    params.require(:expense_category).permit(:expense_source, :description)
  end

  def current_expense_record
    @expense = current_user.expenses.find_by_id(params[:id])
    unless @expense.present?
      flash[:alert] = 'Invalid Access'
      redirect_to expenses_path
    end
  end

  def update_remaining_amount(expense)
    if expense.income_records.present?
      refunded_amount = expense.income_records.pluck(:amount).sum
      expense.remain_amount = (expense.amount.to_f - refunded_amount.to_f).to_i
      expense.refundable = 'YES' if !expense.refundable?
    else
      expense.remain_amount = expense.refundable? ? expense.amount.to_i : 0
    end
    expense.save
  end

end
