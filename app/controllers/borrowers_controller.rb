class BorrowersController < ApplicationController

	before_action :authenticate_user!
	before_action :find_borrower, only:[:edit, :update, :destroy]

	def index
		@borrowers = current_user.borrowers.includes(:borrower_records).order('created_at DESC').paginate(:page => params[:page], :per_page => 15)
	end

	def new
		@borrower = current_user.borrowers.new
	end

	def create
		@borrower = current_user.borrowers.new(borrower_params)
		if @borrower.save
			flash[:success] = "Borrower details added successfully."
			redirect_to borrowers_path
		else
			flash[:alert] = "Something went wrog. Please try again."
			@errors = @borrower.errors.messages
			render :new
		end
	end

	def edit
	end

	def update
		if @borrower.update_attributes(borrower_params)
			flash[:success] = "borrower record updated successfully."
			redirect_to borrowers_path
		else
			flash[:alert] = "something went wrong"
			@errors = @borrower.errors.messages
			render :edit
		end
	end

	def destroy
		if @borrower.borrower_records.pluck(:remain_amount).sum <= 0
			if @borrower.destroy
				flash[:success] = "Borrower records deleted successfully."
				redirect_to borrowers_path
			else
				@errors = @borrower.errors.messages
				flash[:alert] = "Something went wrong"
			end
		else
			flash[:alert] = "Some amount remain from #{@borrower.name}. Don't delete this borrower."
			redirect_to borrowers_path
		end
	end

	private
	def borrower_params
		params.require(:borrower).permit(:name, :email, :contact_num, :relation_with_payer, :user_id)
	end

	def find_borrower
		@borrower = current_user.borrowers.find_by_id(params[:id])
		unless @borrower.present?
			flash[:alert] = "Invalid Access"
			redirect_to borrowers_path
		end
	end

end
