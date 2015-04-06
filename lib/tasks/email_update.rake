class EmailUpdate

  def self.alert_users_to_new_events
    # users_who_need_updates = []
    User.all.each do |user|
    new_events = []
      if user.bands
        user.bands.each do |band|
          if band.events.length > 0
            if band.events.last.created_at > user.last_email_date 
              band.events.each do |event|
                # binding.pry
                if event.updated_at > user.last_email_date
                  # binding.pry
                  new_events << event
                  # users_who_need_updates << user
                 end
              end
            end 
          end     
        end
      end
      # binding.pry
      if new_events.length > 0
        BandMailer.email_update(user, new_events).deliver
      end
    end
    # users_who_need_updates.each do |user|
  end
end
