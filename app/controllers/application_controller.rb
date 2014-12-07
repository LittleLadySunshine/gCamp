class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :logged_in?

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    unless current_user
      redirect_to signin_path, notice: 'You must be logged in access that action.'
    end
  end

  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, with: :access_denied

  def access_denied
    render "public/404", layout: false, status: 404
  end

  helper_method :logged_in?
  helper_method :current_user

end
