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

task :get_new_events => [:environment] do
  UpdateBandEvents.get_new_fb_events
end

