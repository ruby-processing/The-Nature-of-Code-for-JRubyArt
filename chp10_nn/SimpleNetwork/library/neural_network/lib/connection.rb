# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com
# An animated drawing of a Neural Network

class Connection
  include Processing::Proxy

  attr_reader :neuron_a, :neuron_b, :weight, :sending, :sender, :output

  def initialize(from, to, w)
    @weight = w
    @neuron_a = from
    @neuron_b = to
    @sending = false
    @output = 0
  end

  # The Connection is active
  def feedforward(val)
    @output = val * weight             # Compute output
    @sender = neuron_a.location.copy   # Start animation at Neuron A
    @sending = true                    # Turn on sending
  end

  # Update traveling sender
  def update
    return unless sending
    # Use a simple interpolation
    sender.lerp!(neuron_b.location, 0.1)
    d = sender.dist(neuron_b.location)
    # If we've reached the end
    return unless d < 1
    # Pass along the output!
    neuron_b.feedforward(output)
    @sending = false
  end

  # Draw line and traveling circle
  def display
    stroke(0)
    stroke_weight(1 + weight * 4)
    line(neuron_a.location.x, neuron_a.location.y, neuron_b.location.x, neuron_b.location.y)
    return unless sending
    fill(0)
    stroke_weight(1)
    ellipse(sender.x, sender.y, 16, 16)
  end
end

