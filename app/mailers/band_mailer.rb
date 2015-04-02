class UserMailer < ApplicationMailer

  def update_email(user, *event_array)
    @user = user
    @events = event_array
    mail(to: @user.email, subject: "Don't miss out on these shows!")

   

  end
end

# def welcome_email(user)
#     @user = user
#     mail(to: @user.email, subject: "Welcome to our site!")

#   end