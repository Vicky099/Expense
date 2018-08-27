class IncomesController < ApplicationController

  before_filter :authenticate_user!
  before_action :current_income_record, only:[:edit,:update]

  def index
    @incomes = current_user.incomes.order('created_at DESC').paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @income = Income.new
  end

  def create
    @income = Income.new(income_params)
    @income.build_transaction_record(user_id: @income.user_id, record_name: @income.income_category.present? ? @income.income_category.income_source : '')
    if @income.save
      flash[:success] = 'Income added successfully.'
      redirect_to incomes_path
    else
      flash[:danger] = 'Something went wrong. income not added.'
      render :new
    end
  end

  def edit
  end

  def update
    if @income.update_attributes(income_params)
      flash[:success] = "Income updated successfully."
      redirect_to incomes_path
    else
      flash[:danger] = 'Something went wrong to add income.'
      render :edit
    end
  end

  def category
    @income_category= IncomeCategory.new
  end

  def save_income_category
    @income_category= IncomeCategory.new(category_params)
    if @income_category.save
      flash[:success] = 'Category Added successfully.'
      redirect_to category_incomes_path
    else
      flash[:danger] = 'Something went wrong to add category.'
      render :category
    end
  end

  def all_income_category
    @income_category = IncomeCategory.all.paginate(:page => params[:page], :per_page => 15)
  end

  def process_refund
    @income = Income.new(income_params)
    @income.build_transaction_record(user_id: @income.user_id, record_name: @income.income_category.present? ? @income.income_category.income_source : '')
    expense, is_valid = check_refund(@income)
    if is_valid && @income.save && expense.save
      flash[:success] = "Refund processed successfully."
      redirect_to incomes_path
    else
      flash[:alert] = "We are sorry but something is not good. Please check the refund details again."
      redirect_to refund_history_expenses_path
    end
  end

  private

  def income_params
    params.require(:income).permit(:amount, :date, :income_category_id, :user_id, :description, :amount_type, :expense_id, :_destroy)
  end

  def category_params
    params.require(:income_category).permit(:income_source, :description)
  end

  def current_income_record
    @income = current_user.incomes.find_by_id(params[:id])
    unless @income.present?
      flash[:alert] = 'Invalid Access'
      redirect_to incomes_path
    end
  end

  def check_refund(income)
    expense = income.expense_record
    is_valid = true
    if income.amount.to_f == expense.remain_amount.to_f
      income.refund_type = Income.refund_types['full']
      expense.removed = 'YES'
    elsif expense.remain_amount.to_f > income.amount.to_f
      income.refund_type = Income.refund_types['partial']
    elsif expense.remain_amount < income.amount.to_f
      is_valid = false
    end
    expense.remain_amount = (expense.remain_amount.to_f - income.amount.to_f).to_i
    return expense, is_valid
  end
end
