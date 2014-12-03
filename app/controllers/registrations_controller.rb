class RegistrationsController < MarketingController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation)
      )
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path
    else
      signup_up_error = "First name cannot be blank
      /Last name cannot be blank
      /Email cannot be blank
      / Password confirmation doesn't match password
      / Password cannot be blank"
      render :new
    end
  end

end
