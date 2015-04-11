class Search


  attr_accessor :band_params
 
  def initialize(band_params)
    @band_params = band_params
  end

  def search
    binding.pry
    Band.find_by(self.band_params)
  end

end