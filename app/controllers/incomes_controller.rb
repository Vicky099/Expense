class IncomesController < ApplicationController

  before_filter :authenticate_user!
  def index
    @incomes = Income.where('user_id =?', current_user.id).paginate(:page => params[:page], :per_page => 15)
  end

  def new
    @income = Income.new
  end

  def create
    income = Income.new(income_params)
    if income.save
      income.build_transaction_record(process_id: income.id, process_type: income.class.name, user_id: income.user_id, record_name: income.income_category.income_source).save
      flash[:success] = 'Income added successfully.'
      redirect_to incomes_path
    else
      flash[:danger] = 'Something went wrong. income not added.'
      render :incomes
    end
  end

  def edit
    @income = Income.find(params[:id])
  end

  def update
    @income = Income.find(params[:id])
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

  private

  def income_params
    params.require(:income).permit(:amount, :date, :income_category_id, :user_id, :description)
  end

  def category_params
    params.require(:income_category).permit(:income_source, :description)
  end

end
