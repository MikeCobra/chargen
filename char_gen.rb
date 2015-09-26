require 'faraday'
require 'json'
require 'pickup'
require 'simple-random'

template_file = File.open('test_template.json', 'rb')
template_string = template_file.read
template = JSON.parse template_string

def normal_distribution(options)
  sr = SimpleRandom.new
  sr.set_seed

  mean = options['mean']
  std_dev = options['std_dev']

  sr.normal(mean, std_dev).round
end

def weighted_distribution(options)
  pickup = Pickup.new options
  pickup.pick 1
end

def handle_group(options)
  hash = {}
  options.each do |field|
    handle_thing hash, field
  end
  hash
end

def handle_thing(parent, thing)
  thing_name = thing[0]
  thing_options = thing[1]

  thing_value = case thing_options.keys[0]
  when 'normal'
    normal_distribution(thing_options['normal'])
  when 'value'
    thing_options['value']
  when 'group'
    handle_group(thing_options['group'])
  when 'weighted'
    weighted_distribution(thing_options['weighted'])
  else
    raise 'Unsupported thingy-ma-watsit'
  end
  parent[thing_name] = thing_value
end

character = handle_group(template)

conn = Faraday.new(:url => 'http://api.uinames.com') do |faraday|
  faraday.request :url_encoded
  faraday.adapter Faraday.default_adapter
end

response = conn.get '', {:country => character['origin'], :gender => character['gender']}
name = JSON.parse(response.body)

character['name'] = "#{name['name']} #{name['surname']}"

puts JSON.generate character
