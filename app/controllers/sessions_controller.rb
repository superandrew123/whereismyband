class SessionsController < ApplicationController
  def new
    # Bring's a user to the sign-in form
     @user = User.new

  end

  # Creates the new log-in session
  def create
    #allow user to sign in w/ facebook or with a nomo account
    if request.env['omniauth.auth']
      #sign in or up with facebook
      if User.find_by(email: request.env['omniauth.auth'].info.email)
        @user = User.find_by(email: request.env['omniauth.auth'].info.email)
        log_in(@user)
        redirect_to root_path
      else
        @user = User.new
        @user = User.from_omniauth(env["omniauth.auth"], @user)
        binding.pry
        log_in(@user)
        redirect_to root_path
      end
  
    else
    
      @user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])
      if @user
        log_in(@user)
        redirect_to root_path
      else
        @user = User.new
        flash.now[:notice] = "Please use a valid email/password"
        render :new
      end

    end
    



  end

  def destroy
    # Sign the user out
    # binding.pry
    reset_session
    # binding.pry
    # flash[:notice] = "Logged out!"
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end

end
