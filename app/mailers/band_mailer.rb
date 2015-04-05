class BandMailer < ApplicationMailer
  # attr_accessor :log


  # LOG = ["Wed, 01 Apr 2015".to_date]
  
  def email_update(user, *event_array)
    @user = user
    # binding.pry
    @events = event_array.flatten.uniq
    # binding.pry
    mail(to: @user.email, subject: "Don't miss out on these shows!")
    user.last_email_date = Date.today
  end

 

  # def self.log
  #   LOG 
  # end
end

