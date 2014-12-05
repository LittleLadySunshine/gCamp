class ProjectsController < ApplicationController

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?

  before_action :authorize_membership, only: [:show]
  before_action :authorize_owner, only: [:edit, :update, :destroy]


  def index
    if current_user
      @projects = current_user.projects
    else
      @projects = Project.all
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      Membership.create(project_id: @project.id, user_id: current_user.id, role: 'Owner')
      redirect_to project_tasks_path(@project), notice: "Project was created successfully"
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
    if memberships = @project.memberships.where(
      role: 'owner',
      user_id: current_user,
      project_id: @project
      )
    @project.destroy
    redirect_to projects_path, notice: "Project was deleted successfully"
    else
      redirect_to root_path
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
