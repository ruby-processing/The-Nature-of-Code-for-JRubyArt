# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com
# The Network has a list of neurons
class Network
  include Processing::Proxy
  attr_reader :neurons, :connections, :location

  def initialize(x, y)
    @location = Vec2D.new(x, y)
    @neurons = []
    @connections = []
  end

  # We can add a Neuron
  def add_neuron(n)
    neurons << n
  end

  # We can connection two Neurons
  def connect(a, b, weight = 0.5)
    c = Connection.new a, b, weight
    a.join c
    # Also add the Connection here
    connections << c
  end

  # Sending an input to the first Neuron
  # We should do something better to track multiple inputs
  def feedforward(input1, input2)
    n1 = neurons[0]
    n1.feedforward(input1)
    n2 = neurons[1]
    n2.feedforward(input2)
  end

  # Update the animation
  def update
    connections.each(&:update)
  end

  # Draw everything
  def display
    push_matrix
    translate(location.x, location.y)
    neurons.each(&:display)
    connections.each(&:display)
    pop_matrix
  end
end
