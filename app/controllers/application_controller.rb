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

  helper_method :logged_in?

end
