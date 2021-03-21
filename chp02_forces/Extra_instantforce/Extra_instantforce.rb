# Extra_instantforce
# The Nature of Code
# http://natureofcode.com
class Mover
  attr_reader :location

  def initialize(location:)
    @location = location
    @velocity = Vec2D.new(0, 0)
    @acceleration = Vec2D.new(0, 0)
    @mass = 1
  end

  def shake
    force = Vec2D.random
    force *= 0.7
    apply_force(force)
  end

  def apply_force(force:)
    @acceleration += force / @mass
  end

  def update
    @velocity += @acceleration
    @location += @velocity
    @acceleration *= 0
    # Simple friction
    @velocity *= 0.95
  end

  def display
    stroke(0)
    stroke_weight(2)
    fill(127)
    ellipse(@location.x, @location.y, 48, 48)
  end
end

# Extra_instantforce
# The Nature of Code
# http://natureofcode.com

def setup
  sketch_title 'Extra Instant Force'
  @mover = Mover.new(location: Vec2D.new(width, height) / 2.0)
  @t = 0.0
end

def draw
  background(255)
  # Perlin noise wind
  wx = map1d(noise(@t), (-1.0..1.0), (-1..1.0))
  wind = Vec2D.new(wx, 0)
  @t += 0.01
  line(width / 2, height / 2, width / 2 + wind.x * 100, height / 2 + wind.y * 100)
  @mover.apply_force(force: wind)
  if @mover.location.x > width - 50
    boundary = Vec2D.new(-1, 0)
    @mover.apply_force(force: boundary)
  elsif @mover.location.x < 50
    boundary = Vec2D.new(1, 0)
    @mover.apply_force(force: boundary)
  end
  @mover.update
  @mover.display
end

# Instant Force
def mouse_pressed
  cannon = Vec2D.random
  cannon *= 5
  @mover.apply_force(force: cannon)
end

def settings
  size(640, 360)
end
