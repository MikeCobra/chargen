require 'pickup'

class Weighted
  def handle(options)
    pickup = Pickup.new options
    pickup.pick
  end
end
