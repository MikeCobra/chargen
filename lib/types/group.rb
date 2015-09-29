require_relative '../field_handler'

class Group
  def initialize
    @field_handler = FieldHandler.new
  end

  def handle(options)
    hash = {}
    options.each do |name, content|
      hash[name] = @field_handler.handle content
    end
    hash
  end
end
