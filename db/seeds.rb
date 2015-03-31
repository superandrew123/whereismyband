require 'open-uri'

#-----------------------------------------------------
# This seed task will do our initial storing of artist
# and events on our band and events table.
#-----------------------------------------------------

# [A,B,C....,number]
ARRAY = ("a".."z").to_a.push("number")

ARRAY.each do |letter|
  # Nokogiri object for http://www.billboard.com/artists/(letter)
  billboard = Nokogiri::HTML(open("http://www.billboard.com/artists/#{letter}"))
  # iterating through Nokogiri object and getting artist name
  billboard.css('.view-content .field-content a').each do |artist|
    artist_slug = artist.text.gsub(" ","")
    artist_name = artist.text
    puts artist_name
  # catchin error if facebook page exists
    begin
      # binding.pry
      artist_fb = FbGraph::Page.fetch(artist_slug, :access_token => ENV["fb_access_token"])
  # if the musician/band page exists persist that to the bands table
      if artist_fb.category == "Musician/band"
  # before persisting to db make sure artist have a musician/band page
        band = Band.find_or_create_by(name: artist_name)
        if artist_fb.events.length > 0
          artist_fb.events.each do |event|
            show = Event.find_or_create_by(location: event.name, start_time: event.start_time)
            show.link = "http://www.facebook.com/#{artist_slug}/events"
            show.save
            band.events.push(show)
          end
        end
        band.save
      end

    rescue
  # No action needed if no FB page is found
    end
  end
end

