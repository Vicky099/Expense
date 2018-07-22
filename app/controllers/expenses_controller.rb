class ExpensesController < ApplicationController

  before_filter :authenticate_user!
  def index
    @expenses = Expense.where('user_id =?', current_user.id).paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.build_transaction_record(process_id: @expense.id, process_type: @expense.class.name, user_id: @expense.user_id, record_name: @expense.expense_category.present? ? @expense.expense_category.expense_source : '')
    if @expense.save
      flash[:success] = "Expenses added successfully."
      redirect_to expenses_path
    else
      flash[:danger] = "Expenses not added successfully."
      render :new
    end
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update_attributes(expense_params)
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
    @expense_category = ExpenseCategory.all.paginate(:page => params[:page], :per_page => 15)
  end

  private

  def expense_params
    params.require(:expense).permit(:amount, :date, :expense_category_id, :user_id, :description, :_destroy)
  end

  def expense_category_params
    params.require(:expense_category).permit(:expense_source, :description)
  end

end
