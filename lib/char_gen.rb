require 'faraday'
require 'json'

require_relative 'types/character'

filename = ARGV[0]

character_handler = Character.new
character = character_handler.handle 'template_file' => filename

conn = Faraday.new(url: 'http://api.uinames.com') do |faraday|
  faraday.request :url_encoded
  faraday.adapter Faraday.default_adapter
end

name_params = {
  country: character['origin'],
  gender: character['gender']
}

response = conn.get '', name_params
name = JSON.parse(response.body)

character['name'] = "#{name['name']} #{name['surname']}"

puts JSON.pretty_generate character
