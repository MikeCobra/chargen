require_relative 'types/normal'
require_relative 'types/value'
require_relative 'types/group'
require_relative 'types/weighted'

def handle_field(parent, field)
  field_name = field[0]
  field_options = field[1]

  handlers = {}

  handlers['normal'] = Normal.new
  handlers['value'] = Value.new
  handlers['group'] = Group.new
  handlers['weighted'] = Weighted.new

  field_type = field_options.keys[0]
  if handlers.keys.include? field_type then
    field_value = handlers[field_type].handle(field_options[field_type])
  else
    raise "Unsupported type #{field_type}"
  end

  parent[field_name] = field_value
end
