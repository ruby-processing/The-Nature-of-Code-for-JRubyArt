# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# A static drawing of a Neural Network
load_library :neural_network

attr_reader :network

def setup
  sketch_title 'Noc 10 03 Network Viz'
  # Create the Network object
  @network = Network.new(width / 2, height / 2)
  # Create a bunch of s
  a = Neuron.new(-200, 0)
  b = Neuron.new(0, 75)
  c = Neuron.new(0, -75)
  d = Neuron.new(200, 0)
  # Connect them
  network.connect(a, b)
  network.connect(a, c)
  network.connect(b, d)
  network.connect(c, d)
  # Add them to the Network
  network.neurons = [a, b, c, d]
end

def draw
  background(255)
  # Draw the Network
  network.display
  no_loop
end

def settings
  size 640, 360
end
