class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end

  before_action :logged_in?
  before_action :set_membership, only: [:update, :destroy]
  before_action :current_user_has_membership_permission
  before_action :current_user_is_owner_to_edit, only: [:create, :update]
  before_action :can_delete_membership, only: [:destroy]


  def index
    if current_user.admin == false
      member = @project.memberships.where(user_id: current_user.id)
      @role = member[0]
    end
    @membership = @project.memberships.new
    @memberships = @project.memberships.all
    owner = @project.memberships.where(role: "owner")
    total_owners = owner.count
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if current_user.admin == false
      member = @project.memberships.where(user_id: current_user.id)
      @role = member[0]
      @membership.save
      @id = @membership.user_id
      redirect_to project_memberships_path(@project),
      notice: "#{User.find(@id).full_name} was successfully created."
    end

    @membership = @project.memberships.new(membership_params)
      if @role == "owner" || current_user.admin == true
        if @membership.save
          redirect_to project_memberships_path(@project),
          notice: "#{@membership.user.full_name} was successfully created."
        else
          owners = @project.memberships.where(role: "owner")
          @total_owners = owners.count
          @memberships = @project.memberships.all
          render :index
        end
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
      if current_user.admin == false
        @membership = @project.membership.fine(param[:id])
        member = @project.memberships.where(user_id: current_user.id)
        @role = member[0]
      end

      @owners = @project.memberships.where(role: "owner")
        if @role == 'member' && @role == "owner" || current_user.admin == true
          @membership.destroy
          redirect_to projects_path, notice: "#{@membership.user.full_name} was removed successfully"
        elsif @owners.count > 1 && @role == "owner" || current_user.admin == true
          if @membership.user.id == current_user.id
            @membership.destroy
            redirect_to projects path
          else
            @membership.destroy
            redirect_to project_memberships_path(
            @project), notice: "#{@membership.user.full_name} was removed successfully"
          end
        elsif @role == "owner" || current_user.admin == true
          if @membership.user.id != current_user.id
            @membership.destroy
            redirect_to project_memberships_path(
            @project), notice: "#{@membership.user.full_name} was removed successfully"
          end
        else
        raise AccessDenied
        end
  end

  private

  def set_membership
    @membership = @project.memberships.find(params[:id])
  end

  def current_user_has_membership_permission
    if @project.memberships.where(user_id: current_user.id)
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
    current_membership = @project.all.memberships.where(user_id: current_user.id)
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

  def membership_params
    params.require(:membership).permit(:user_id, :role, :project_id)
  end
end
