require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'faker'

# Clear all the tables first
PlayerLeague.delete_all
League.delete_all
Type.delete_all
Player.delete_all
Country.delete_all
puts 'Deleted all table'

# Function to fetch data
def fetch_data(urlString)
  url = URI(urlString)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  request = Net::HTTP::Get.new(url)
  request['X-RapidAPI-Key'] = 'RZFbtPzPjymshBTePpvz3NzvYJHGp175bvxjsnWj7QxJfn7dza'
  request['X-RapidAPI-Host'] = 'api-football-v1.p.rapidapi.com'

  response = http.request(request)
  JSON.parse(response.read_body)
end

# Main code to fetch the API
returned_content = fetch_data('https://webdev2.winandmac.com/sample.json')
leagues = returned_content['response']

# Loop through the returned items
leagues.each do |league|

  # Main code to fetch the country info
  country = {}

  if "#{league['country']['code']}".empty?
    puts 'Country is null or world'
  else

    # We need to replace some weird stuff before requesting the API
    current_country = league['country']['name'].gsub("-", "%20")
    if current_country == "England"
      current_country = "United%20Kingdom"
    end

    # Request #1 source for the country info
    country_info = fetch_data("https://restcountries.com/v3.1/name/#{current_country}")

    # Make sure there are something returned
    if country_info.class == Array

      # Modify the languages info returned and turn that to string
      country_languages = country_info[0]["languages"].map{|k, v| v}

      # Assign to the country variable so that we can add that easily in the future
      country["capital"] = country_info[0]["capital"].join(", ")
      country["region"] = country_info[0]["region"]
      country["languages"] = country_languages.join(", ")
      country["population"] = country_info[0]["population"]
      country["area"] = country_info[0]["area"]
    end
  end

  # Create the type and country
  type = Type.find_or_create_by(name: league['league']['type'])
  country = Country.find_or_create_by(
    name: league['country']['name'],
    code: league['country']['code'],
    flag: league['country']['flag'],
    capital: country["capital"],
    region: country["region"],
    languages: country["languages"],
    population: country["population"],
    area: country["area"])

  # Find out the id so that we can add that to the League table correctly
  current_type_id = Type.where({ name: league['league']['type'] }).first.id

  # Create the associated item to the League table by country object
  new_item = country.leagues.create(
    name: league['league']['name'],
    logo: league['league']['logo'],
    season: league['seasons'][0]['start'],
    type_id: current_type_id
  )

  rand(10..100).times do
    player = Player.find_or_create_by(name: Faker::Name.name)
    PlayerLeague.create(player: player, league: new_item)
  end

end
