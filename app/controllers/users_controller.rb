class UsersController < ApplicationController
  def new
    @user = User.new
  end 

  def create
    # creating a new user account from
    # the "users#new" route
    @user = User.new(user_params)
    if @user.save
      # Create a new session when a new user account is created
      log_in(@user)
      redirect_to root_path, :notice => "Account created!"
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
