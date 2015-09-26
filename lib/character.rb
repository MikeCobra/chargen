require_relative 'types/group'

class Character
  def self.generate(template)
      Group.new.handle(template)
  end
end
