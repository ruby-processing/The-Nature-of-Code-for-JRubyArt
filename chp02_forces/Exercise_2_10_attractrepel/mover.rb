# The Nature of Code
# http://natureofcode.com
G = 1 # kind of pointless gravitational constant

# Mover class
class Mover
  include Processing::Proxy
  attr_reader :location, :mass

  def initialize(location:, mass:)
    @location = location
    @velocity = Vec2D.new
    @acceleration = Vec2D.new
    @mass = mass
  end

  def apply_force(force:)
    @acceleration += force / @mass
  end

  def update
    @velocity += @acceleration
    @location += @velocity
    @acceleration *= 0
  end

  def display
    stroke(0)
    fill(175, 200)
    ellipse(@location.x, @location.y, @mass * 2, @mass * 2)
  end

  def repel(mover:)
    force = @location - mover.location     # Calculate direction of force
    distance = force.mag                   # Distance between objects
    # Limit "extreme" results for very close or very far objects
    distance = constrain(distance, 1.0, 10_000.0)
    # Normalize we just want this vector for direction
    force.normalize!
    # Calculate gravitional force magnitude
    strength = (G * @mass * mover.mass) / (distance * distance)
    force *= -strength           # Get force vector --> magnitude * direction
    force
  end
end
