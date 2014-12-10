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
      redirect_to signin_path, notice: "You must be logged in to access that action"
    end
  end

  class AccessDenied < StandardError

  end

  rescue_from AccessDenied, with: :record_not_found

  def record_not_found
    render "public/404", status: 404, layout: false
  end

  def owner?(project, user)
    membership = Membership.where(:project_id => project.id, :user_id => user.id).pluck(:id)
    if Membership.find_by(id: membership[0]).role == Role.find_by("owner")
      true
    else
      false
    end
  end

  helper_method :owner?

  def has_owner?(project)
    owners = Membership.where(:project_id => project.id, :role_id => Role.find_by_role("owner").id).pluck(:id)
    if owners.count >= 2
      true
    else
      false
    end
  end

  helper_method :has_owner?


end
