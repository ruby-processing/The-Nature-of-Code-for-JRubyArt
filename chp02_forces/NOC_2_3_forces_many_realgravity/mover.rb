# Mover class
class Mover
  include Processing::Proxy

  attr_reader :mass

  def initialize(mass, x, y)
    @location = Vec2D.new(x, y)
    @velocity = Vec2D.new(0, 0)
    @acceleration = Vec2D.new(0, 0)
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
    stroke_weight(2)
    fill(127)
    ellipse(@location.x, @location.y, @mass * 16, @mass * 16)
  end

  def check_edges(max_x:, max_y:)
    if @location.x > max_x
      @location.x = max_x
      @velocity.x *= -1
    elsif @location.x < 0
      @location.x = 0
      @velocity.x *= -1
    end
    if @location.y > max_y
      @location.y = max_y
      @velocity.y *= -1
    elsif @location.y < 0
      @location.y = 0
      @velocity.y *= -1
    end
  end
end
