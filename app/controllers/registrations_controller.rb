class RegistrationsController < Devise::RegistrationsController
  
  #before_filter :authenticate_user!
  def new
    super
  end

  def create
    @user = User.new(user_params)
    if @user.save
      set_role(@user)
      flash[:success] = 'User registered successfully.'
       redirect_to new_user_session_path
    else
      flash[:danger] = 'User not registered successfully.'
      render action: :new
    end
  end
 
  private
  def user_params
    params.require(:user).permit(:name , :email, :password, :password_confirmation)
  end
  
  def set_role(user)
    user.update_attributes(:role => "client")    
  end
  
end
