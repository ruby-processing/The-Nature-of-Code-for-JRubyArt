# The Nature of Code
# http://natureofcode.com

class CannonBall
  attr_reader :location

  def initialize(x, y)
    @location = Vec2D.new(x, y)
    @velocity = Vec2D.new
    @acceleration = Vec2D.new
    @topspeed = 10
    @r = 8
  end

  # Standard Euler integration
  def update
    @velocity += @acceleration
    @velocity.set_mag(@topspeed) {@velocity.mag > @topspeed}
    @location += @velocity
    @acceleration *= 0
  end

  def apply_force(force)
    @acceleration += force
  end

  def display
    stroke(0)
    stroke_weight(2)
    push_matrix()
    translate(@location.x, @location.y)
    ellipse(0, 0, @r * 2, @r * 2)
    pop_matrix
  end
end

attr_reader :angle, :location

def setup
  sketch_title 'Exercise 3 03 Cannon'
  # All of this stuff should go into a Cannon class
  @angle = -PI / 4
  @location = Vec2D.new(50, 300)
  @shot = false
  @ball = CannonBall.new(location.x, location.y)
end

def draw
  background(255)
  push_matrix
  translate(location.x, location.y)
  rotate(angle)
  rect(0, -5, 50, 10)
  pop_matrix
  if @shot
    gravity = Vec2D.new(0, 0.2)
    @ball.apply_force(gravity)
    @ball.update
  end
  @ball.display
  if @ball.location.y > height or @ball.location.x > width
    @ball = CannonBall.new(location.x, location.y)
    @shot = false
  end
end

def key_pressed
  if key == CODED && key_code == RIGHT
    @angle += 0.1
  elsif key == CODED && key_code == LEFT
    @angle -= 0.1
  elsif key == ' '
    @shot = true
    force = Vec2D.new(Math.cos(angle), Math.sin(angle))
    force *= 10
    @ball.apply_force(force)
  end
end

def settings
  size(640, 360)
end

