require_relative '../field_handler'

class Group
  def initialize
    @field_handler = FieldHandler.new
  end

  def handle(options)
    hash = {}
    options.each do |field|
      @field_handler.handle hash, field
    end
    hash
  end
end
