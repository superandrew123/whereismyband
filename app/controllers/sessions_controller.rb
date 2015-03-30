class SessionsController < ApplicationController
  def new
    # Bring's a user to the sign-in form
    # @user = User.new

  end

  def create
    # binding.pry
    # Creates the new log-in session
    @user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
    if @user
      # binding.pry
      login(@user)
      redirect_to root_path
    else
      @user = User.new
      flash.now[:notice] = "Please use a valid email/password"
      render :new
    end

  end

  def destroy
    # Sign the user out
    # binding.pry
    reset_session
    # binding.pry
    flash[:notice] = "Logged out!"
    redirect_to root_path

    
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end

end
