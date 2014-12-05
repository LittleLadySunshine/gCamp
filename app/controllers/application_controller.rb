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

  def authorize_membership
    # @project = Project.find(params[:id])
    # unless current_user.is_Member?(@project)
    #   raise AccessDenied
    # end
  end

  def authorize_owner
    # @project = Project.find(params[:id])
    # unless current_user.is_Owner?(@project)
    #   raise AccessDenied
    # end
  end



  helper_method :logged_in?


end
