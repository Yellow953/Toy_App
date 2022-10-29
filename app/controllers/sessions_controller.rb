class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)      
        flash[:success] = "User logged in successfully"
        redirect_back_or user
      else 
        flash[:warning] = "Account not activated! Check your email for activation link!"
        redirect_to root_path
      end  
    else
      flash[:danger] = "Invalid Email/Password. Please try again!"
      redirect_to login_path
    end  
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end  
end
