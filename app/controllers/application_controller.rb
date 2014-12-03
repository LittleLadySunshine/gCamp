class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

before_action :require_login

  def current_user
  User.find_by(id: session[:user_id])
end

  helper_method :current_user

  def require_membership
    @membership = Membership.where(:user_id, :current_user.id)
    membership = @membership.pluck()

end
