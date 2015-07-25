# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com
# An animated drawing of a Neural Network

class Network
  include Processing::Proxy
  attr_accessor :neurons # this accessor is used to add neurons
  attr_reader :connections, :location

  def initialize(x, y)
    @location = Vec2D.new(x, y)
    @connections = []
  end

  # We can connection two Neurons
  def connect(a, b, weight = 0.5)
    c = Connection.new(a, b, weight)
    a.join(c)
    # Also add them to the network
    connections << c
  end

  # Sending an input to the first Neuron
  # We should do something better to track multiple inputs
  def feedforward(input)
    start = neurons.first
    start.feedforward(input)
  end

  # Update the animation
  def update
    connections.each { |c| c.update }
  end

  # Draw everything
  def display
    push_matrix
    translate(location.x, location.y)
    neurons.each { |n| n.display }
    connections.each { |c| c.display }
    pop_matrix
  end
end
