class UsersController < ApplicationController


  def index
    @user = User.all
  end


# GET /tasks/1
# GET /tasks/1.json
  def show
    @user = User.find(params[:id])
  end

# GET /tasks/new
  def new
    @user = User.new
  end

# GET /tasks/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation)
        )
        format.html { redirect_to users_path, notice:
          'User was successfully updated.' }
        format.json { render :index, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

# POST /tasks
# POST /tasks.json
  def create
    @user = User.new(params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation)
      )
    respond_to do |format|
      if @user.valid?
        @user.save
        format.html { redirect_to users_path, notice:
          'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end




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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
    end
  end
end
