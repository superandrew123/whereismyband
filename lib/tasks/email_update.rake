class EmailUpdate

  def self.alert_users_to_new_events
    User.all.each do |user|
      if user.bands
        new_events = []
        user.bands.each do |band|
          # binding.pry
          if band.events.last.created_at > BandMailer.log.last
            # binding.pry
            band.events.each do |event|
              if event.updated_at > BandMailer.log.last
                # binding.pry
                new_events << event
               end
            end
          end      
        end
        binding.pry
        BandMailer.email_update(user, new_events).deliver
        # puts "email sent!"
      end
    end
  end
end