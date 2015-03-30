class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def log_in(user)
    # Creates a key on session called :user_id
    # and a value of the user account's id.
    session[:user_id] = user.id
  end
end
