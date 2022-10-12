require 'uri'
require 'net/http'
require 'openssl'
require 'json'

# Clear all the tables first
League.delete_all
Type.delete_all
Country.delete_all
puts "Deleted all table"

# Function to fetch data
def fetch_data(urlString)
  url = URI(urlString)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request["X-RapidAPI-Key"] = 'RZFbtPzPjymshBTePpvz3NzvYJHGp175bvxjsnWj7QxJfn7dza'
  request["X-RapidAPI-Host"] = 'api-football-v1.p.rapidapi.com'

  response = http.request(request)
  content = JSON.parse(response.read_body)

  return content
end

# Main code to fetch the API
returned_content = fetch_data("https://webdev2.winandmac.com/sample.json")
leagues = returned_content["response"]

# Loop through the returned items
leagues.each do |league|

  # Create the type and country first
  type = Type.find_or_create_by(name: league["league"]["type"])
  country = Country.find_or_create_by(name: league["country"]["name"])

  # Find out the id so that we can add that to the League table correctly
  current_type_id = Type.where({name: league["league"]["type"]}).first.id

  # Create the associated item to the League table by country object
  country.leagues.create(
    name: league["league"]["name"],
    logo: league["league"]["logo"],
    season: league["seasons"][0]["start"],
    type_id: current_type_id)
end