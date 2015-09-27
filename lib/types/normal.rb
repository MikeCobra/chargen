require 'simple-random'

class Normal
  def initialize
      @random_generator = SimpleRandom.new
      @random_generator.set_seed
  end

  def handle(options)
    mean = options['mean']
    std_dev = options['std_dev']

    min = options['min']
    max = options['max']

    value = @random_generator.normal(mean, std_dev).round

    if min and value < min then
      value = min
    end

    if max and value > max then
      value = max
    end

    value
  end
end
