class EmailUpdate

  def self.alert_users_to_new_events
    users_who_need_updates = []
    new_events = []
    User.all.each do |user|
      if user.bands
        user.bands.each do |band|
          if band.events.length > 0
            if band.events.last.created_at > user.last_email_date 
              band.events.each do |event|
                if event.updated_at > user.last_email_date
                  new_events << event
                  users_who_need_updates << user
                 end
              end
            end 
          end     
        end
      end
    end
    users_who_need_updates.each do |user|
      BandMailer.email_update(user, new_events).deliver
    end
  end
end