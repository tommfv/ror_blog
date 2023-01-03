class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:index, :create, :new]

  def index
    @users = User.all.order(:id)
  end

  def new
    @user = User.new
  end
  
  def create
    @default_password = "admin1"
    @user = User.new(user_params_save.merge(
      password: @default_password,
      password_confirmation: @default_password,
      confirmed_at: Time.now
    ))
    @user.skip_confirmation!
    if @user.save
      flash[:success] = "Create new user success"
      redirect_to users_path
    else
      flash[:error] = @user.errors
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "Delete user success"
      redirect_to users_path
    else
      flash[:error] = 'Error can not delete user'
      render :show
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params_update)
      flash[:success] = "Profile updated"
      redirect_to users_path
    else
      render :edit
    end
  end

  def change_password
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render :change_password
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

  def user_params_update
    params.require(:user).permit(:name, :company, :admin)
  end

  def user_params_save
    params.require(:user).permit(:email, :name, :company, :admin)
  end

  def authorize_admin
    return unless !current_user.admin?
    redirect_to root_path, alert: 'Only Admin have access !' 
  end
  
end
