#  NOC_4_09_AdditiveBlending
# The Nature of Code
# http://natureofcode.com

class Particle
  include Processing::Proxy
  attr_reader :acceleration, :lifespan, :location, :velocity

  def initialize(location, img)
    @acceleration = Vec2D.new(0, 0.05)
    @velocity = Vec2D.new(rand(-1.0 .. 1), rand(-1.0 .. 0))
    @velocity *= 2
    @location = location.copy
    @img = img
    @lifespan = 255.0
  end

  def run
    update
    render
  end

  # Method to update location
  def update
    @velocity += acceleration
    @location += velocity
    @lifespan -= 2.0
  end

  # Method to display
  def render
    image_mode(CENTER)
    tint(lifespan)
    image(@img, location.x, location.y)
  end

  # Is the particle still useful?
  def dead?
    lifespan < 0.0
  end
end


