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

    if (!min.nil? && !max.nil?) && (min > max)
      fail "Minimum #{min} is greater than Maximum #{max}."
    end

    value = @random_generator.normal(mean, std_dev).round

    if min && value < min then value = min end

    if max && value > max then value = max end

    value
  end
end
