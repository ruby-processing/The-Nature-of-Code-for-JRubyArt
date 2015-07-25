# The Nature of Code
# http://natureofcode.com

# Simple Particle System
# A simple Particle class

class Particle
  include Processing::Proxy

  def initialize(location)
    @acceleration = Vec2D.new(0, 0.05)
    @velocity = Vec2D.new(rand(-1.0 .. 1), rand(-1 ..0))
    @location = location.copy
    @lifespan = 255.0
  end

  def run
    update
    display
  end

  # Method to update location
  def update
    @velocity += @acceleration
    @location += @velocity
    @lifespan -= 2.0
  end

  # Method to display
  def display
    stroke(0, @lifespan)
    stroke_weight(2)
    fill(127, @lifespan)
    ellipse(@location.x, @location.y, 12, 12)
  end

  # Is the particle still useful?
  def dead?
    @lifespan < 0.0
  end
end
