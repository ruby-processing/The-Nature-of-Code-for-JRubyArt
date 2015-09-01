# The Nature of Code
# http://natureofcode.com

# A simple Particle class

class Particle
  include Processing::Proxy

  attr_reader :acceleration, :lifespan, :location, :velocity

  def initialize(location:)
    @acceleration = Vec2D.new(0, 0.05)
    @velocity = Vec2D.new(rand(-1.0..1), rand(-1.0..0))
    @location = location
    @lifespan = 255
  end

  def run
    update
    display
    puts 'Particle dead!' if lifespan < 0
  end

  # Method to update location
  def update
    @velocity += acceleration
    @location += velocity
    @lifespan -= 2
  end

  # Method to display
  def display
    stroke(0, lifespan)
    stroke_weight(2)
    fill(127, lifespan)
    ellipse(location.x, location.y, 12, 12)
  end
end
