class Ville < ActiveRecord::Base
  before_validation :geocode
  
  def meteo
      ForecastIO.forecast(self.latitude, self.longitude, params: { units: 'si' })
  end

    
  
  # Color for display temperature
  def colorTemperature(celsusTemperature)
    if celsusTemperature.nil?
      return ""
    elsif celsusTemperature < 0
      return "text-info"
    elsif celsusTemperature < 15
      return "text-primary"
    elsif celsusTemperature < 30
      return "text-warning"
    else
      return "text-danger"
    end
  end
  
  private
    def geocode
      places= Nominatim.search(self.nom).limit(1)
      place=places.first
      if place 
        self.latitude=place.latitude
        self.longitude=place.longitude
      end
    end
    
end

 
  

