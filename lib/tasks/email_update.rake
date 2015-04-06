class EmailUpdate

  def self.alert_users_to_new_events
    User.all.each do |user|
    new_events = []
      if user.bands
        user.bands.each do |band|
          if band.events.length > 0
            if band.events.last.created_at > user.last_email_date 
              band.events.each do |event|
                if event.updated_at > user.last_email_date
                  new_events << event
                 end
              end
            end 
          end     
        end
      end
      if new_events.length > 0
        BandMailer.email_update(user, new_events).deliver
      end
    end
  end
end
    # users_who_need_updates.each do |user|
    # new_events = []
#     email_to_be_sent = []
#     UserBands.all.each do |user_band|
#       email = []
#       events_array = []
#       if user_band.band.events.length > 0
#         if user_band.band.events.last.created_at > user_band.user.last_email_date
#           email << user_band.user
#           user_band.band.events.each do |event|
#             if event.updated_at > user.last_email_date
#               events_array << event
#             end
#           end
#           email << events_array
#         end
#       end
#       # if user.bands
#       #   user.bands.each do |band|
#       #     if band.events.length > 0
#       #       if band.events.last.created_at > user.last_email_date 
#       #         band.events.each do |event|
#       #           if event.updated_at > user.last_email_date
#       #             new_events << event
#       #             users_who_need_updates << user
#       #            end
#       #         end
#       #       end 
#       #     end     
#       #   end
#       # end
#       email_to_be_sent << email
#     end
    
#     # email_to_be_sent ~= [[user1, [event1, event2, event3]],
#     #                      [user2, [event1, event2, event3]],
#     #                      [user3, [event1, event2]]
#     #                       ]

#     email_to_be_sent.each do |email|
#       BandMailer.email_update(email[0], email[1]).deliver
#     end
# >>>>>>> f8056d84a82c9b89e9a8152aaf367ab203ec6ff0
#   end
# end
