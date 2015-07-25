# The Nature of Code
# http://natureofcode.com

class Mover
  include Processing::Proxy

  attr_reader :location, :mass

  def initialize(m, x , y)
    @mass = m;
    @location = Vec2D.new(x,y)
    @velocity = Vec2D.new(0,0)
    @acceleration = Vec2D.new(0,0)
  end

  def apply_force(force)
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

  def repel(mover)
    force = @location - mover.location     # Calculate direction of force
    distance = force.mag                             # Distance between objects
    # Limit "extreme" results for very close or very far objects
    distance = constrain(distance, 1.0, 10_000.0)
    # Normalize we just want this vector for direction
    force.normalize!
    # Calculate gravitional force magnitude
    strength = (G * @mass * mover.mass) / (distance * distance)
    force *= -strength           # Get force vector --> magnitude * direction
    force
  end

  def check_edges
    if @location.x > width
      @location.x = width
      @velocity.x *= -1
    elsif @location.x < 0
      @location.x = 0
      @velocity.x *= -1
    end

    if @location.y > height
      @location.y = height
      @velocity.y *= -1
    elsif @location.y < 0
      @location.y = 0
      @velocity.y *= -1
    end
  end
end


