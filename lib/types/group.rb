require_relative '../field'

class Group
  def handle(options)
    hash = {}
    options.each do |field|
      handle_field hash, field
    end
    hash
  end
end
