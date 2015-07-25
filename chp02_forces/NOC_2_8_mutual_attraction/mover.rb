class Mover
  include Processing::Proxy

  attr_reader :acceleration, :mass, :velocity, :location
  G = 0.4

  def initialize(x, y, m)
    @location = Vec2D.new(x, y)
    @velocity = Vec2D.new(0, 0)
    @acceleration = Vec2D.new(0, 0)
    @mass = m
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
    stroke_weight(2)
    fill(0, 100)
    ellipse(location.x, location.y, mass * 24, mass * 24)
  end

  def attract(mover)
    force = location - mover.location
    distance = force.mag
    distance = constrain(distance, 5.0, 25.0)
    force.normalize!
    strength = (G * mass * mass) / (distance * distance)
    force *= strength
    force
  end
end
