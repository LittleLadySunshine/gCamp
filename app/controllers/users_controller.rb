class UsersController < ApplicationController

  def index
    @user = User.all
  end


# GET /tasks/1
# GET /tasks/1.json
  def show
  end

# GET /tasks/new
  def new
    @user = User.new
  end

# GET /tasks/1/edit
  def edit
  end

# POST /tasks
# POST /tasks.json
  def create
    @user = User.new

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
