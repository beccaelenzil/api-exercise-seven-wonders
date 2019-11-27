# seven-wonders.rb
URL = 'https://us1.locationiq.org/v1/search.php'
KEY = ENV['LOCATION_IQ_API_KEY']

def get_locations(places)

  place_locations = {}

  places.each do |place|
    response = HTTParty.get(URL, query:{
      q: place,
      key: KEY,
      format: "json"
    })

    if response.code == 200
      place_locations[place] = {
        lat: response.first["lat"], 
        lon: response.first["lon"]
      }
    else
      place_locations[place] = {
        lat: nil, 
        lon: nil
      }
    end

    #sleep(0.5)
  end
  return place_locations
end

