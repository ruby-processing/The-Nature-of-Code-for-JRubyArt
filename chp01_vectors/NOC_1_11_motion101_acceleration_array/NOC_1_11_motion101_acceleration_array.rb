# The Nature of Code
# http://natureofcode.com
# NOC_1_11_motion101_acceleration_array


class Mover
  RADIUS = 24
  TOP_SPEED = 6
  attr_reader :location, :velocity, :topspeed_squared

  def initialize(max_x:, max_y:)
    @location = Vec2D.new(rand(RADIUS..max_x - RADIUS), rand(RADIUS..max_y - RADIUS))
    @velocity = Vec2D.new(0, 0)
  end

  def update
    mouse = Vec2D.new(mouse_x, mouse_y)
    acceleration = mouse - location
    acceleration.normalize!
    acceleration *= 0.2
    @velocity += acceleration
    velocity.set_mag(TOP_SPEED) { velocity.mag > TOP_SPEED }
    @location += velocity
  end

  def display
    stroke(0)
    stroke_weight(2)
    fill(127)
    ellipse(location.x, location.y, RADIUS * 2, RADIUS * 2)
  end
end

def setup
  sketch_title ' Motion 101 Acceleration Array'
  @movers = Array.new(20) { Mover.new(max_x: width, max_y: height) }
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
