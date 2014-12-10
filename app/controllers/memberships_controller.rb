class MembershipsController < ApplicationController

  before_action :logged_in?

  before_action do
    @project = Project.find(params[:project_id])
  end

  before_action :only => [:edit, :update, :destroy] do
    set_membership
    if owner?(@project, current_user)
    else
      raise AccessDenied
    end
  end



  def index
    @memberships = @project.memberships.all
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      redirect_to project_memberships_path,
      :notice => "#{@membership.user.full_name} was added successfully"
    else
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


    def update
      set_membership
      @membership.update(membership_params)
      redirect_to project_memberships_path,
      :notice => "#{@membership.user.full_name} was updated successfully"
    end



    def destroy
      set_membership
      if @project.memberships.count != 1 || has_owner?(@project)
        @membership.destroy
        redirect_to project_memberships_path,
        :notice => "#{@membership.user.full_name} was deleted successfully"
      else
        render "index"
      end
    end
  end

  private

  def set_membership
    @membership = @project.memberships.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :role, :project_id)
  end
end
