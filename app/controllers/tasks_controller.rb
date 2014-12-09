class TasksController < ApplicationController
  before_action :current_user_has_tasks_permission

  before_action do
    @project = Project.find(params[:project_id])
  end

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = @project.tasks.where(complete: false)
    if params[:sort] == 'all'
      @tasks = @project.tasks.all
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
    @task = @project.tasks.find(params[:id])
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
    @task = @project.tasks.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_task_path(@project, @task),
          notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_tasks_path(@project),
        notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:project_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:description, :complete, :due_date)
  end


  def current_user_has_tasks_permission
    unless (Project.all.memberships.pluck(:user_id).include? current_user.id) || (current_user.admin == true)
      raise AccessDenied
    end
  end


end
