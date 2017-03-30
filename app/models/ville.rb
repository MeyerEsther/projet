class Ville < ActiveRecord::Base
  before_validation :geocode
  
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
