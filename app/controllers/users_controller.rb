class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
  before_action :logged_in_user, only: %i[ index show edit update destroy ]
  before_action :correct_user, only: %i[ edit update ]
  before_action :admin_user, only: :destroy

  # GET /users or /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user= User.find(params[:id])
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "User was successfully registered."
      log_in @user
      redirect_to root_path
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:warning] = "User was successfully updated."
        format.html { redirect_to user_url(@user) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:danger] = "User was successfully deleted."
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in!"
        redirect_to login_path        
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin? 
    end
    
end
