class MembershipsController < ApplicationController
  before_action :set_membership, only: [:update, :destroy]
  before_action :current_user_has_membership_permission
  before_action :current_user_is_owner_to_edit, only: [:create, :update]
  before_action :can_delete_membership, only: [:destroy]
  before_action :logged_in?
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
    if @membership.update(params.require(:membership).permit(:project_id, :user_id, :role))
      redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was updated successfully"
    else
      render :index
    end
  end

  def destroy
    @membership = @project.memberships.find(params[:id])
    if @membership.destroy
      if (@project.memberships.pluck(:user_id).include? current_user.id) || current_user.admin == true
        redirect_to project_memberships_path, notice: "#{@membership.user.full_name} was deleted successfully"
      else
        redirect_to projects_path, notice: "#{@membership.user.full_name} was deleted successfully"
      end
    else
      render :index
    end
  end

  private

  def set_membership
    @membership = @project.memberships.find(params[:id])
  end

  def current_user_has_membership_permission
    if (@project.memberships.pluck(:user_id).include? current_user.id) || (current_user.admin == true)
      true
    else
      raise AccessDenied
    end
  end

  def current_user_is_owner_to_edit
    current_membership = @project.memberships.where(user_id: current_user.id)
    current_membership.each do |membership|
      @membership_role = membership.role
      if (membership.role == "owner") || (current_user.admin == true)
        true
      else
        raise AccessDenied
      end
    end
  end

  def can_delete_membership
    current_membership = @project.memberships.where(user_id: current_user.id)
    current_membership.each do |membership|
      @membership_role = membership.role
      if (membership.role == "owner") || (current_user.admin == true)
        true
      elsif @membership.user_id == current_user.id
        true
      else
        raise AccessDenied
      end
    end
  end
  
  def set_membership
    @membership = @project.memberships.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :title).merge(
    :project_id => params[:project_id])
  end
end
