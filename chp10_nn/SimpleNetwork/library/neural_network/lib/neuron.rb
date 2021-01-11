# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com
# An animated drawing of a Neural Network
class Neuron
  include Processing::Proxy
  ACTIVATION_THRESHOLD = 1.0

  attr_reader :connections, :location, :sum, :r

  def initialize(location:)
    @location = location
    @connections = []
    @r = 32
    @sum = 0
  end

  # Add a connection to the neuron object
  def join(c)
    connections << c
  end

  # Receive an input
  def feedforward(input)
    # Accumulate it
    @sum += input
    # Activate the neuron when it reaches its threshold
    return sum unless sum > ACTIVATION_THRESHOLD

    fire
    @sum = 0 # On firing the resting action potential is set to 0
  end

  # The Neuron fires
  def fire
    @r = 64 # display a bigger ellipse to indicate firing
    # We forward the signal through all connections
    connections.each { |c| c.feedforward(sum) }
  end

  # Draw it as a circle
  def display
    stroke(0)
    stroke_weight(1)
    # Brightness is mapped to the accumulated action potential
    b = map1d(sum, (0..1), (255..0))
    fill(b)
    ellipse(location.x, location.y, r, r)
    # Size shrinks down back to original dimensions
    @r = lerp(r, 32, 0.1)
  end
end
