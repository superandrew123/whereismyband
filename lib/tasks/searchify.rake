class Searchify
  def self.start
    Band.all.each do |band|
      band.search_name = band.name.downcase if band.name
      band.save
      puts "#{band.name} => #{band.search_name}"
    end
  end
end