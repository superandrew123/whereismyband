# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks


task :console do
  Pry.start
end


task :searchify => [:environment] do
	Searchify.start
end

task :eliminate_past_events => [:environment] do
  UpdateBandEvents.elminate_past_events
end

task :get_new_events_first => [:environment] do
  UpdateBandEvents.get_new_fb_events_first
end

task :get_new_events_second => [:environment] do
  UpdateBandEvents.get_new_fb_events_second
end

task :get_new_events_third => [:environment] do
  UpdateBandEvents.get_new_fb_events_third
end

task :get_new_events_fourth => [:environment] do
  UpdateBandEvents.get_new_fb_events_fourth
end

task :get_new_events_fifth => [:environment] do
  UpdateBandEvents.get_new_fb_events_fifth
end

task :get_new_events_sixth => [:environment] do
  UpdateBandEvents.get_new_fb_events_fifth
end

task :update_user_with_new_events => [:environment] do
  EmailUpdate.alert_users_to_new_events
end

