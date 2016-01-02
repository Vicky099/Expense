class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  
  protect_from_forgery with:  :null_session
  after_filter :store_location
  
  def after_sign_out_path_for(resources)
    new_user_session_path
  end
  
  def authenticate_user!
   unless user_signed_in?
     flash[:danger] = "You must login first"
     redirect_to new_user_session_path
   end
  end
  
  def store_location
    return unless request.get? 
    if request.fullpath == "/dashboards"
      session[:previous_url] = dashboards_path
    end
  end
  
  def after_sign_in_path_for(resources)
     session[:previous_url] || dashboards_path
  end
  
end
