class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user_can_edit_own_info, only: [:edit, :update, :destroy]

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    if (current_user != nil) && current_user.admin == true
      @user = User.new(params.require(:user).permit(:first_name, :last_name, :email,
      :password, :password_confirmation, :admin))
    else
      @user = User.new(user_params)
    end
    if @user.save
      redirect_to users_url, notice: 'User was successfully created.'
    else
      render :new
    end
  end
  
  def update
    if (current_user != nil) && current_user.admin == true
      if @user.update(params.require(:user).permit(:first_name, :last_name, :email, :admin))
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    else
      if @user.update(params.require(:user).permit(:first_name, :last_name, :email))
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
    end
  end

  private

  def user_params
    params.require(:user).permit(
    :first_name,
    :last_name,
    :email,
    :password,
    :password_confirmation
    )
  end


  def set_user
    @user = User.find(params[:id])
  end


  def current_user_can_edit_own_info
    if @user.id == current_user.id || current_user.admin == true
    else
      raise AccessDenied
    end
  end
end
