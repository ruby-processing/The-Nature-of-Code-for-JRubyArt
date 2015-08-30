# A simple mover class
class Mover
  include Processing::Proxy

  attr_reader :acceleration, :mass, :velocity, :location, :diameter
  def initialize
    @location = Vec2D.new(400, 50)
    @velocity = Vec2D.new(1, 0)
    @acceleration = Vec2D.new(0, 0)
    @mass = 1
    @diameter = mass * 24
  end

  def apply_force(force:)
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
    ellipse(location.x, location.y, diameter, diameter)
  end
end
