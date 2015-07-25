class Mover
  include Processing::Proxy

  attr_reader :acceleration, :mass, :velocity, :location
  def initialize
    @location = Vec2D.new(400, 50)
    @velocity = Vec2D.new(1, 0)
    @acceleration = Vec2D.new(0, 0)
    @mass = 1
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
    fill(127)
    ellipse(location.x, location.y, mass * 16, mass * 16)
  end

  def check_edges(width, height)
    if location.x > width
      location.x = 0
    elsif location.x < 0
      location.x = width
    end
    if location.y > height
      location.y = height
      velocity.y *= -1
    end
  end
end

