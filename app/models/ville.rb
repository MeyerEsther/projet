class Ville < ActiveRecord::Base
  before_validation :geocode
  
  
  def Weather
    forecast = ForecastIO.forecast(self.latitude, self.longitude, params: { units: 'si' })
    weatherCheck = false
    temperatureCheck = false
    
    if forecast
      todayForecast = forecast.currently
      if todayForecast
        if todayForecast.summary
          weatherSummary = todayForecast.summary
          weatherCheck = true
        end
        if todayForecast.icon
          weatherIconName = todayForecast.icon
           weatherFetched = true
         end
      if todayForecast.temperature
          weatherTemperature = todayForecast.temperature
          temperatureCheck = true
        end
      end
    end
  if !weatherCheck
      weatherSummary =nil
      weatherIconName = nil
    end
  if !temperatureCheck
      weatherTemperature = nil
    end 
    
    return   {"weatherIconName" => weatherIconName, "weatherTemperature" => weatherTemperature, "weatherSummary" => weatherSummary}
    
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

 
  

