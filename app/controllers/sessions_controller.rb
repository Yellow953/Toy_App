class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        flash[:success] = "User logged in successfully"
        redirect_to root_path
    else
      flash[:danger] = "Invalid Email/Password. Please try again!"
      redirect_to login_path
    end  
  end

  def destroy

  end  
end
