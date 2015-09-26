require 'simple-random'

class Normal
  def handle(options)
    sr = SimpleRandom.new
    sr.set_seed

    mean = options['mean']
    std_dev = options['std_dev']

    sr.normal(mean, std_dev).round
  end
end
