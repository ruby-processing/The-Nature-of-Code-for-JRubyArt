# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com
# The static network
class StaticNetwork
  include Processing::Proxy
  attr_reader :neurons, :location

  def initialize(layers, inputs, _outputs)
    @location = Vec2D.new(width / 2, height / 2)
    @neurons = []
    output = Neuron.new(250, 0)
    layers.times do |i|
      inputs.times do |j|
        x = map1d(i, (0 .. layers), (-200 .. 200))
        y = map1d(j, (0 .. inputs-1), (-100 .. 100))
        puts "#{j} #{y}"
        n = Neuron.new(x, y)
        if i > 0
          inputs.times do |k|
            prev = neurons[neurons.size - inputs + k - j]
            prev.join(n)
          end
        end
        n.join(output) if (i == layers - 1)
        neurons << n
      end
    end
    neurons << output
  end

  def display
    push_matrix
    translate(location.x, location.y)
    neurons.each(&:display)
    pop_matrix
  end
end
