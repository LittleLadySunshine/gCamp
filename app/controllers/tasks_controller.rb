class TasksController < ApplicationController
  # before_action :current_user_has_tasks_permission
  before_action :logged_in?
  before_action do
    @project = Project.find(params[:project_id])
  end

  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :only => [:show, :edit, :update, :destroy] do
    set_task
    if current_user.admin || @project.users.include?(current_user)
    else
      raise AccessDenied
    end
  end

  # GET /tasks
  # GET /tasks.json

  def index
    @tasks = if params[:sort_by] == 'complete'
      @project.tasks.where(:complete => false)
    else
      @project.tasks.all
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    @comment = @task.comments.new
    @comments = @task.comments.all
  end

  # GET /tasks/new
  def new
    @task = @project.tasks.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if @task.update(task_params)
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    redirect_to project_tasks_path, notice: 'Task was successfully destroyed.'
  end

  private
  # # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = @project.tasks.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:description, :complete, :due_date)
  end


  # def current_user_has_tasks_permission
  #   unless (@project.pluck(:user_id).include? current_user.id) || (current_user.admin == true)
  #     raise AccessDenied
  #   end
  # end


end
