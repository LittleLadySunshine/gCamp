class ProjectsController < ApplicationController

  before_action :logged_in?
  before_action :only => [:show] do
    set_project
  if @project.users.include? current_user
  else
    raise AccessDenied
  end
end

before_action :only => [:edit, :update, :destroy] do
  set_project
  if owner?(@project, current_user)
  else
    raise AccessDenied
  end
end


  def index
    @projects = Project.all
  end



  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @membership = @project.memberships.new(
    :project_id => @project.id,
    :user_id => current_user.id,
    :role_id => Role.find_by_role("owner").id)
    @membership.save
    if @project.save
      redirect_to project_tasks_path(@project), notice: "Project was created successfully"
    else
      render :new
    end
  end


  def edit
    set_project
  end

  def show
    set_project
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
    set_project
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully destroyed.'
  end



  private

  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end

end
