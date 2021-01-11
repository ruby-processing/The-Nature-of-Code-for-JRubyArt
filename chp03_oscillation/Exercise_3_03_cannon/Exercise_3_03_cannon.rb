# The Nature of Code
# http://natureofcode.com
class CannonBall
  attr_reader :position, :radius, :topspeed, :velocity

  def initialize(location:)
    @position = location
    @velocity = Vec2D.new
    @acceleration = Vec2D.new
    @topspeed = 10
    @radius = 8
  end

  # Standard Euler integration
  def update
    @velocity += @acceleration
    velocity.set_mag(topspeed) { velocity.mag > topspeed }
    @position += velocity
    @acceleration *= 0
  end

  def apply_force(force:)
    @acceleration += force
  end

  def display
    stroke(0)
    stroke_weight(2)
    push_matrix
    translate(position.x, position.y)
    ellipse(0, 0, radius * 2, radius * 2)
    pop_matrix
  end
end

attr_reader :angle, :ball, :position

def setup
  sketch_title 'Exercise Cannon'
  # All of this stuff should go into a Cannon class
  @angle = -PI / 4
  @position = Vec2D.new(50, 300)
  @shot = false
  @ball = CannonBall.new(location: position)
end

def draw
  background(255)
  push_matrix
  translate(position.x, position.y)
  rotate(angle)
  rect(0, -5, 50, 10)
  pop_matrix
  if @shot
    gravity = Vec2D.new(0, 0.2)
    ball.apply_force(force: gravity)
    ball.update
  end
  ball.display
  return unless ball.position.y > height || ball.position.x > width

  @ball = CannonBall.new(location: position)
  @shot = false
end

def key_pressed
  if key == CODED && key_code == RIGHT
    @angle += 0.1
  elsif key == CODED && key_code == LEFT
    @angle -= 0.1
  elsif key == ' '
    @shot = true
    propel = Vec2D.new(Math.cos(angle), Math.sin(angle))
    propel *= 10
    ball.apply_force(force: propel)
  end
end

def settings
  size(640, 360)
end
