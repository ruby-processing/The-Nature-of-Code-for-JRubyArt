

class Mover
  include Processing::Proxy

  G = 0.4 # gravitational constant

  attr_reader :acceleration, :location, :mass, :velocity

  def initialize(m, x, y)
    @mass = m
    @location = Vec2D.new(x, y)
    @velocity = Vec2D.new
    @acceleration = Vec2D.new
  end

  def apply_force(force)
    @acceleration += force / mass
  end

  def update
    @velocity += acceleration
    @location += velocity
    @acceleration *= 0
  end

  def display
    stroke(0)
    fill(175, 200)
    ellipse(location.x, location.y, mass * 16, mass * 16)
  end

  def attract(mover)
    force = location - mover.location                   # Calculate direction of force
    distance = force.mag                                         # Distance between objects
    distance = constrain(distance, 5.0, 25.0)                    # Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize!                                              # Normalize vector (distance doesn't matter here, we just want this vector for direction
    strength = (G * mass * mover.mass) / (distance * distance) # Calculate gravitional force magnitude
    force *= strength                                         # Get force vector --> magnitude * direction
  end

  def boundaries width, height
    d = 50
    force = Vec2D.new
    if location.x < d
      force.x = 1
    elsif location.x > width - d
      force.x = -1
    end
    if location.y < d
      force.y = 1
    elsif location.y > height - d
      force.y = -1
    end
    force.set_mag 0.1
    apply_force(force)
  end
end
