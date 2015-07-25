# The Nature of Code
# http://natureofcode.com
# NOC_1_11_motion101_acceleration_array


class Mover
  TOP_SPEED = 6
  attr_reader :location, :velocity, :topspeed_squared

  def initialize(width, height)
    @location = Vec2D.new(rand(width/2.0), rand(height/2.0))
    @velocity = Vec2D.new(0, 0)
  end

  def update
    mouse = Vec2D.new(mouse_x, mouse_y)
    acceleration = mouse - location
    acceleration.normalize!
    acceleration *= 0.2
    @velocity += acceleration
    velocity.set_mag(TOP_SPEED) {velocity.mag > TOP_SPEED}
    @location += velocity
  end

  def display
    stroke(0)
    stroke_weight(2)
    fill(127)
    ellipse(location.x, location.y, 48, 48)
  end
end

def setup
  sketch_title 'Noc 1 11 Motion101 Acceleration Array'
  @movers = Array.new(20) { Mover.new(width, height) }
end

def draw
  background(255)
  @movers.each do |mover|
    mover.update
    mover.display
  end
end

def settings
  size(800, 200)
end

