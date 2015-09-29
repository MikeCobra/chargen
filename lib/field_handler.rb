require_relative 'types/normal'
require_relative 'types/value'
require_relative 'types/group'
require_relative 'types/weighted'

class FieldHandler
  def handle(field)
    field_type = field.keys[0]
    field_options = field[field_type]

    handler = select_handler(field_type)

    handler.handle(field_options)
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
