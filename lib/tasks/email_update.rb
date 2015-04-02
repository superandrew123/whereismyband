class EmailUpdate

  def alert_users_to_new_events
    User.all.each do |user|
      if user.bands
        new_events = []
        user.bands.each do |band|
          if band.updated_at > when last email was sent
            band.events.each do |event|
              if event.updated_at > when last email was sent
                new_events << event
               end
            end
          end
        end
        UserMailer.update_email(user, new_events)
      end
    end
  end