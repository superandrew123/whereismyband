class BandMailer < ApplicationMailer
  # attr_accessor :log


  # LOG = ["Wed, 01 Apr 2015".to_date]
  
  def email_update(user, *event_array)
    @user = user

    @events = event_array.flatten.uniq
    # binding.pry
    mail(to: @user.email, subject: "Don't miss out on these shows!")
    binding.pry
    user.last_email_date = Time.now
    user.save
    # binding.pry
  end

 

  # def self.log
  #   LOG 
  # end
end

