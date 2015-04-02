class UpdateBandEvents 

  def self.elminate_past_events
    Band.all.each do |band|
      band.events.each do |event|
        if event.start_time < Date.today
          event.destroy
        end
      end
      puts "#{band.name}"
    end
  end

  def self.get_new_fb_events
    Band.all.each do |band|
      band_slug = band.name.gsub(" ","")
      fb_band = FbGraph::Page.fetch(band_slug, :access_token => ENV["fb_access_token"])
      if fb_band.events
        fb_band.events.each do |event|
          show = Event.find_or_create_by(location: event.name, start_time: event.start_time)
          show.link = "http://www.facebook.com/#{band_slug}/events"
          show.save    
          band.events.push(show)
        end
      band.save
      puts "#{band.name}"
      end
    end
  end

end