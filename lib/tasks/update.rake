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

  def self.get_new_fb_events_first
    Band.where(id: 26..1000).each do |band|
        band_slug = band.fb_slug || band.name.gsub(" ","")
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

  def self.get_new_fb_events_second
    Band.where(id: 1001..2000).each do |band|
      band_slug = band.fb_slug || band.name.gsub(" ","")
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

  def self.get_new_fb_events_third
    Band.where(id: 2001..3000).each do |band|
      band_slug = band.fb_slug || band.name.gsub(" ","")
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

  def self.get_new_fb_events_fourth
    Band.where(id: 3001..4000).each do |band|
      band_slug = band.fb_slug || band.name.gsub(" ","")
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

  def self.get_new_fb_events_fifth
    Band.where(id: 4001..5000).each do |band|
      band_slug = band.fb_slug || band.name.gsub(" ","")
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

  def self.get_new_fb_events_sixth
    Band.where(id: 5001..5998).each do |band|
      band_slug = band.fb_slug || band.name.gsub(" ","")
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