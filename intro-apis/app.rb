require "rest-client"
require "pry"
require "json"

#location of my api
URL = "http://pokeapi.co/api/v2/"
# binding.pry
result = JSON.parse(RestClient.get(URL+"pokemon"))
result["results"].each do |k,v|
  puts "Key => #{k}, Value => #{v}"
end
