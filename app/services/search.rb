class SearchBands


  attr_accessor :band_params
 
  def initialize(band_params)
    @band_params = band_params
  end

  def search
    Band.find_by(self.band_params)
  end

end