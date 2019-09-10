require 'httparty'
require 'dotenv'
require 'awesome_print'

#Tell dotenv to look for the .env file
Dotenv.load

#Starter Code:
seven_wonders = ["Great Pyramid of Giza", "Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

US_URL = "https://us1.locationiq.com/v1/search.php?"
EU_URL = "https://eu1.locationiq.com/v1/search.php?"
KEY = ENV['LOCATION_IQ_API_KEY']

seven_wonders_locations = {}
seven_wonders.each do |wonder|
  
  response = HTTParty.get(US_URL, query: {
    q: wonder,
    key: KEY,
    format: 'json'
  })

  #ap response.parsed_response.class

  begin
    latitude = response.first["lat"]
    longitude = response.first["lon"]
    #latitude = response.first[1]["place"]["lat"]
    #longitude = response.first[1]["place"]["lon"]
  rescue
    latitude = nil
    longitude = nil
  end

  puts "#{latitude},#{longitude}"

  seven_wonders_locations[wonder] = {"lat"=>latitude, "long"=>longitude}

  #sleep(0.2)
end

puts seven_wonders_locations







#Example Output:
#{"Great Pyramind of Giza"=>{"lat"=>29.9792345, "lng"=>31.1342019}, "Hanging Gardens of Babylon"=>{"lat"=>32.5422374, "lng"=>44.42103609999999}, "Colossus of Rhodes"=>{"lat"=>36.45106560000001, "lng"=>28.2258333}, "Pharos of Alexandria"=>{"lat"=>38.7904054, "lng"=>-77.040581}, "Statue of Zeus at Olympia"=>{"lat"=>37.6379375, "lng"=>21.6302601}, "Temple of Artemis"=>{"lat"=>37.9498715, "lng"=>27.3633807}, "Mausoleum at Halicarnassus"=>{"lat"=>37.038132, "lng"=>27.4243849}}
