require_relative 'types/normal'
require_relative 'types/value'
require_relative 'types/group'
require_relative 'types/weighted'

class FieldHandler
  def handle(parent, field)
    field_name = field[0]
    field_options = field[1]

    field_type = field_options.keys[0]

    handler = select_handler(field_type)

    parent[field_name] = handler.handle(field_options[field_type])
  end

  private

  def select_handler(field_type)
    !@handlers && setup_handlers

    if @handlers.keys.include? field_type
      @handlers[field_type]
    else
      fail "Unsupported type #{field_type}"
    end
  end

  def setup_handlers
    @handlers = {}

    @handlers['normal'] = Normal.new
    @handlers['value'] = Value.new
    @handlers['group'] = Group.new
    @handlers['weighted'] = Weighted.new
  end
end
