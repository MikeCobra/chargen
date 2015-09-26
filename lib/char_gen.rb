require 'faraday'
require 'json'

require_relative 'character'

filename = ARGV[0]

template_file = File.open filename, 'rb'
template_string = template_file.read
template = JSON.parse template_string

character = Character.generate(template)

conn = Faraday.new(:url => 'http://api.uinames.com') do |faraday|
  faraday.request :url_encoded
  faraday.adapter Faraday.default_adapter
end

response = conn.get '', {:country => character['origin'], :gender => character['gender']}
name = JSON.parse(response.body)

character['name'] = "#{name['name']} #{name['surname']}"

puts JSON.generate character
