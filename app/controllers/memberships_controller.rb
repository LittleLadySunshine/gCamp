class MembershipsController < ApplicationController
  before_action :logged_in?
  before_action :has_membership
  before_action :require_owner, only: [:new, :create, :edit, :update]

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    member = @project.memberships.where(user_id: current_user.id)
    @role = member[0].role
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
    owners = @project.memberships.where(role: "owner")
    @total_owners = owners.count
    @owners = @project.memberships.where(role: "owner")
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      redirect_to project_memberships_path(@project, @membership),
      notice: "#{@membership.user.full_name} was successfully created."
    else
      @memberships = @project.memberships.all
      render :index
    end
  end

  def show
    @membership = @project.memberships.find(params[:id])
  end


  def new
    @membership = @project.memberships.new
  end

  def edit
    @membership = @project.memberships.find(params[:id])
  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      redirect_to project_memberships_path(@project, @membership),
        notice: "#{@membership.user.full_name} was successfully updated."
    else
      render :index
    end
  end

  def authorize_membership
    # current_user.projects.include?(@project)
    # project_list = Membership.where(user_id: current_user.id).pluck(:project_id)
    # unless project_list.include?(@project.id)
    #   raise AccessDenied
    end

    def authorize_owner
      # @project = Project.find(params[:project_id])
      # unless current_user.is_owner?(@project)
      #   raise AccessDenied
      # end
    end


  def destroy
    @membership = @project.memberships.find(params[:id])
    temp_name = @membership.user.full_name
    @membership.destroy
    redirect_to project_memberships_path(@project, @membership),
      notice: "#{temp_name} was successfully destroyed."
  end

  private


  def membership_params
    params.require(:membership).permit(:user_id, :title).merge(
    :project_id => params[:project_id])
  end
end
