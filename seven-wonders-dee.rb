require 'dotenv'
require 'httparty'
require 'awesome_print'
require 'pry'
​
Dotenv.load
​
seven_wonders = ["Great Pyramid of Giza", "Hanging Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Mausoleum at Halicarnassus"]
​
def find_coordinates(locations)
  
  # Combine all of the latitude and longitudes into one data structure
  result = {}
  
  # Find the latitude and longitude for every location    
  locations.each do |location|
    url = 'https://us1.locationiq.com/v1/search.php'
    
    query_params = {
      key: ENV["LOCATION_IQ_KEY"],
      q: location
    }
    
    response = HTTParty.get(url, query: query_params)
    
    sleep(1)
    
    # If there is NOT an error, find the lat/lon
    if response["searchresults"]["error"].nil?
      # Find the latitude and longitude for one location
      lat = response["searchresults"]["place"]["lat"]
      lon = response["searchresults"]["place"]["lon"]
      
      puts lat
      puts lon
      result[location] = {
        "lat" => lat.to_f,
        "lng" => lon.to_f
      }
    end
  end
  
  return result
  
end
​
ap find_coordinates(seven_wonders)
Collapse