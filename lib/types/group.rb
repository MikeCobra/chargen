require_relative '../field_handler'

class Group
  def handle(options)
    field_handler = FieldHandler.new

    hash = {}
    options.each do |field|
      field_handler.handle hash, field
    end
    hash
  end
end
