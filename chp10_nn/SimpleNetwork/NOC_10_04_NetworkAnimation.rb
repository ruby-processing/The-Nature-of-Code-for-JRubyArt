# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com
# An animated drawing of a Neural Network
load_libraries :neural_network

attr_reader :network

def setup
  sketch_title 'Noc 10 04 Network Animation'
  # Create the Network object
  @network = Network.new(location: Vec2D.new(width / 2, height / 2))
  # Create a bunch of Neurons
  a = Neuron.new(location: Vec2D.new(-275, 0))
  b = Neuron.new(location: Vec2D.new(-150, 0))
  c = Neuron.new(location: Vec2D.new(0, 75))
  d = Neuron.new(location: Vec2D.new(0, -75))
  e = Neuron.new(location: Vec2D.new(150, 0))
  f = Neuron.new(location: Vec2D.new(275, 0))
  # Connect them
  network.connect(from: a, to: b, weight: 1.0)
  network.connect(from: b, to: c, weight: rand)
  network.connect(from: b, to: d, weight: rand)
  network.connect(from: c, to: e, weight: rand)
  network.connect(from: d, to: e, weight: rand)
  network.connect(from: e, to: f, weight: 1.0)
  # Add them to the Network
  network.neurons = [a, b, c, d, e, f]
end

def draw
  background(255)
  # Update and display the Network
  network.update
  network.display
  # Every 30 frames feed in an input
  network.feedforward(rand) if (frame_count % 30 == 0)
end

def settings
  size(640, 360)
end
