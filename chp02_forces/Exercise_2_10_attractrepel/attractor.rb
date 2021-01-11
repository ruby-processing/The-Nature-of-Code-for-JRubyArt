# Attractor class
class Attractor
  include Processing::Proxy

  attr_reader :mass, :location

  def initialize(location:)
    @location = location
    @mass = 10
    @drag_offset = Vec2D.new(0.0, 0.0)
    @dragging = false
    @rollover = false
  end

  def attract(mover:)
    force = location - mover.location  # Calculate direction of force
    d = force.mag                      # Distance between objects
    # Limit the distance to eliminate "extremes"
    d = constrain(d, 5.0, 25.0)
    force.normalize! # Normalize vector to get direction
    strength = (G * mass * mover.mass) / (d * d) # magnitude of g. force
    force *= strength # Get force vector --> magnitude * direction
    force
  end

  def display
    ellipse_mode CENTER
    stroke 0
    if @dragging
      fill 50
    elsif @rollover
      fill 100
    else
      fill 0
    end
    ellipse(location.x, location.y, mass * 6, mass * 6)
  end
end
