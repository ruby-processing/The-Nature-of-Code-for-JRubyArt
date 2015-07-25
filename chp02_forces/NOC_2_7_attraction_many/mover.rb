# NOC_2_7_attraction_many
# The Nature of Code
# http://natureofcode.com
# A class for a draggable attractive body in our world


class Mover
  include Processing::Proxy

  attr_reader :acceleration, :mass, :velocity, :location
  def initialize(x, y, m)
    @location = Vec2D.new(x, y)
    @velocity = Vec2D.new(1, 0)
    @acceleration = Vec2D.new
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
    ellipse(location.x, location.y, mass*25, mass*25)
  end
end



