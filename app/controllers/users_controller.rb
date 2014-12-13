class UsersController < ApplicationController
  before_action :logged_in?
  before_action :only => [:edit, :update, :destroy] do
    set_user
    if current_user.admin || @user == current_user
    else
      raise AccessDenied
    end
  end

  def index
    if current_user.admin
      @users = User.all
    else
      @users = []
      current_user.projects.each do |project|
        @users += project.users
      end
      @users = @users.uniq
    end
  end


  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end


  def edit
    set_user
  end

  def show
    set_user
  end

  def update
    set_user
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    set_user
    @user.destroy
    redirect_to users_path, notice: "User was succesfully deleted"
  end


  private

  def user_params
    if current_user.admin
      params.require(:user).permit(:first_name, :last_name, :email,
      :password,:password_confirmation, :tracker_token,
      :admin)
    else
      params.require(:user).permit(:first_name, :last_name, :email,
      :password,:password_confirmation, :tracker_token)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
  
end
