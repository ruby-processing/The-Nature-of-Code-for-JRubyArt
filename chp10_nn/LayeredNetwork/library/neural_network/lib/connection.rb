# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# An animated drawing of a Neural Network

class Connection
  include Processing::Proxy
  # Connection is from A to B
  attr_reader :a, :b, :weight, :sending, :sender, :output

  def initialize(from, to, w)
    @weight, @a, @b = w, from, to
    @sending = false
    @sender = Vec2D.new
    @output = 0
  end

  # The Connection is active
  def feedforward(val)
    @output = val * weight      # Compute output
    @sender = a.origin          # Start animation at originating neuron
    @sending = true             # Turn on sending
  end

  # Update traveling sender
  def update
    return unless sending       # favour a guard clause in ruby
    # Use a simple interpolation
    sender.lerp!(b.location, 0.1)
    d = sender.dist(b.location)
    # If we've reached the end
    return unless d < 1
    # Pass along the output!
    b.feedforward(output)
    @sending = false
  end

  # Draw line and traveling circle
  def display
    stroke(0)
    stroke_weight(1 + weight * 4)
    draw_line a.location, b.location
    return unless sending
    fill(0)
    stroke_weight(1)
    ellipse(sender.x, sender.y, 16, 16)
  end

  def draw_line(a, b)
    line a.x, a.y, b.x, b.y
  end
end

