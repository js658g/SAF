# $Id: faraday_test.rb 95 2016-04-06 20:35:25Z e0c2506 $
require 'faraday'
require 'json'

# For fun, lets track how many requests we make.
num_requests = 0

# Create a new http client. Not sure if this creates a persistent connection,
# or if it resets the connection each message. Can we test that?
client = Faraday.new(url: 'http://services.groupkt.com/') do |faraday|
  # Faraday can be adapted (heh get it?) to use a different HTTP client under
  # it.
  faraday.adapter Faraday.default_adapter
end

# Here is a get call. Simple, right?
# This returns a list of countries and their country codes.
response = client.get '/country/get/all'
num_requests += 1
# Parsing the response we got...
json_response = JSON.parse response.body
list_of_countries = json_response["RestResponse"]["result"]
Random.srand
my_country_id = Random.rand(list_of_countries.count)
my_country = nil
list_of_states = nil

loop do
  my_country = list_of_countries[my_country_id]

  # This returns a list of regions/states in the passed country (not sure its
  # accurate data though)
  response = client.get "/state/get/#{my_country['alpha3_code']}/all"
  num_requests += 1
  json_response = JSON.parse response.body
  list_of_states = json_response["RestResponse"]["result"]

  # Lets keep looking until we find somewhere with states.
  break if list_of_states.count > 0
  my_country_id = Random.rand(list_of_countries.count)

  puts "Wow its hard to find a country with states!"\
       "#{my_country["name"]} doesn't have any at all!"
  # Ungracefully exiting the program because the webservice will cut us off
  # around 15 requests.
  if num_requests > 10 then
    raise Exception.new("Wow its hard to find a country with states!")
  end
end

puts "The states in #{my_country['name']} are\n"\
     "#{list_of_states.map { |x| x['name'] }.join(",\n")}."
puts "\nI made #{num_request} REST requests today."
