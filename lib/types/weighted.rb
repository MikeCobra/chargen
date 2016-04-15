require 'pickup'

class Weighted
  def handle(options)
    Pickup.new(options).pick
  end
end
