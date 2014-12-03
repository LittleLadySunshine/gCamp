class ProjectsController < ApplicationController
  before_action :logged_in?
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: "Project was created successfully"
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def show
    @project = Project.find(params[:id])
  end

  def update
    set_project
    if @project.update(project_params)
      redirect_to projects_path, notice: "Project was updated successfully"
    else
      render :edit
    end
  end

  def destroy
    # role = owner
    # project_id has to match
    # user_id current_user
    memberships = @project.memberships.where(role: 'owner', user_id: current_user)
    if memberships.empty?
      render 'public/404', status: 404
    else
    set_project
    @project.destroy
    redirect_to projects_path, notice: "Project was deleted successfully"
  end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end

end
