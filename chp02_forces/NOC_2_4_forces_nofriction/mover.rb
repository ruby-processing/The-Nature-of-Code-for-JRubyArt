class Mover
  include Processing::Proxy

  attr_reader :acceleration, :location, :mass, :radius, :velocity
  def initialize(mass, x, y)
    @location = Vec2D.new(x, y)
    @velocity = Vec2D.new
    @acceleration = Vec2D.new
    @mass = mass
    @radius = mass * 8
  end

  def apply_force(force)
    @acceleration += force / mass
  end

  def apply_forces(*forces)
    force = forces.reduce(:+)
    apply_force(force)
  end

  def update
    @velocity += acceleration
    @location += velocity
    @acceleration *= 0
  end

  def display
    stroke(0)
    stroke_weight(2)
    fill(0, 127)
    ellipse(location.x, location.y, radius * 2, radius * 2)
  end

  def check_edges(max_x:, max_y:)
    max_x -= radius
    max_y -= radius
    if location.x > max_x
      @location.x = max_x
      @velocity.x *= -1
    elsif location.x < radius
      @location.x = radius
      @velocity.x *= -1
    end
    if location.y > max_y
      @location.y = max_y
      @velocity.y *= -1
    elsif location.y < radius
      @location.y = radius
      @velocity.y *= -1
    end
  end
end