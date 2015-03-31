Band.all.each do |band|
  name = band.name.gsub(" ", "")
  shows = FbGraph::Page.fetch(name, :access_token => ACCESS_TOKEN).events
  shows.each do |show|
    # binding.pry
    event = Event.find_or_create_by(location: show.name, start_time: show.start_time)
    event.link = "http://www.facebook.com/#{name}/events"
    event.save

    band.events << event
    band.save
  end
end
