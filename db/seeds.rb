require 'open-uri'
#-----------------------------------------------------
# This seed task will do our initial storing of artist
# and events on our band and events table.
#-----------------------------------------------------
ACCESS_TOKEN = "800988173324571|81u92rE9wxm9MRLp93No22qKqTM"
valid_artist_array = Array.new
invalid_artist_array = Array.new
("a".."z").to_a.push("number").each do |letter|
  # Nokogiri object for http://www.billboard.com/artists/(letter)
  billboard = Nokogiri::HTML(open("http://www.billboard.com/artists/#{letter}"))
  # iterating through Nokogiri object and getting artist name
  billboard.css('.view-content .field-content a').each do |artist|
    artist_slug = artist.text.gsub(" ","")
    artist_name = artist.text
  # catchin error if facebook page exists
    begin
      artist_fb = FbGraph::Page.fetch(artist_slug, :access_token => ACCESS_TOKEN)
  # if the musician/band page exists persist that to the bands table
      if artist_fb.category == "Musician/band"
  # before persisting to db make sure artist have a musician/band page
        band = Band.create(name: artist_name)
        if artist_fb.events.length > 0

          artist_fb.events.each do |event|
            event = Event.find_or_create_by(location: show.name, start_time: show.start_time)
            event.link = "http://www.facebook.com/#{name}/events"
            event.save
            band.events.push(event)
          end
        end
        band.save
      end

    rescue
    end
  end
end
