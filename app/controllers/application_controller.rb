class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :logged_in?


  def current_user
  User.find_by(id: session[:user_id])
end

  helper_method :current_user

  def logged_in?
    unless current_user
      redirect_to signin_path, notice: 'You must be logged in access that action.'
    end
  end

  def project_id_match
    project_list = Membership.where(user_id: current_user.id).pluck(:project_id)
    @project = Project.find(params[:id])
    unless projet_list.include?(@project.id)
      raise AccessDenied
    end
  end

  def has_membership
    memberships = Membership.where(user_id: current_user.id)
    member_projects = memberships.pluck(:project_id)
    unless member_projects.include?(@project.id)
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def require_owner
    @role = @project.memberships.where(user_id: current_user.id).first.role
    unless
      @role == "owner"
      render 'public', status: :not_found, layout: false
    end
  end



  helper_method :logged_in?


end
