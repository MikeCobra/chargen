require 'simple-random'

class Normal
  def initialize(random = nil)
      if random.nil? then
        @random_generator = SimpleRandom.new
        @random_generator.set_seed
      else
        @random_generator = random
      end
  end

  def handle(options)
    mean = options['mean']
    std_dev = options['std_dev']

    min = options['min']
    max = options['max']

    if (!min.nil? and !max.nil?) and (min > max) then
      raise "Minimum #{min} is greater than Maximum #{max}."
    end

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
