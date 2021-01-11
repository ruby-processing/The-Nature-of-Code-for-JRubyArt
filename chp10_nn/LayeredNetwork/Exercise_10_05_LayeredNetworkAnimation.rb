# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# An animated drawing of a Neural Network
load_libraries :neural_network

attr_reader :network, :output

def setup
  sketch_title 'Exercise 10 05 Layered Network Animation'
  # Create the Network object
  @network = Network.new(width / 2, height / 2)
  layers = 3
  inputs = 2
  @output = Neuron.new 250, 0
  (0...layers).each do |i|
    inputs.times do |j|
      x = map1d(i, (0..layers), (-250..300))
      y = map1d(j, (0..inputs - 1), (-75..75))
      n = Neuron.new(x, y)
      if i > 0
        (0...inputs).each do |k|
          prev = network.neurons[network.neurons.size - inputs + k - j]
          network.connect(prev, n, rand)
        end
      end
      network.connect(n, output, rand) if i == layers - 1
      network.add_neuron(n)
    end
  end
  network.add_neuron(output)
end

def draw
  background 255
  # Update and display the Network
  network.update
  network.display
  # Every 30 frames feed in an input
  network.feedforward(rand, rand) if (frame_count % 30).zero?
end

def settings
  size 640, 360
end
