# Extra_instantforce
# The Nature of Code
# http://natureofcode.com

class Mover

  attr_reader :location

  def initialize(width, height)
    @location = Vec2D.new(width/2, height/2)
    @velocity = Vec2D.new(0, 0)
    @acceleration = Vec2D.new(0, 0)
    @mass = 1
  end

  def shake
     force = Vec2D.new(rand, rand)
     force *= 0.7
     apply_force(force)
  end

  def apply_force(force)
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

  def check_edges(width, height)
    return if ((0 .. width).include?(@location.x) && @location.y < height)
    if @location.x > width
      @location.x = width
      @velocity.x *= -1
    elsif @location.x < 0
      @velocity.x *= -1
      @location.x = 0
    end
    if @location.y > height
      @velocity.y *= -1
      @location.y = height
    end
  end
end

# Extra_instantforce
# The Nature of Code
# http://natureofcode.com

def setup
  sketch_title 'Extra Instantforce'
  @mover = Mover.new(width, height)
  @t = 0.0
end

def draw
  background(255)
  # Perlin noise wind
  wx = map1d(noise(@t), (0 .. 1), (-1 .. 1))
  wind = Vec2D.new(wx, 0)
  @t += 0.01
  line(width / 2, height / 2, width / 2 + wind.x * 100, height / 2 + wind.y *  100)
  @mover.apply_force(wind)
  # Gravity
  gravity = Vec2D.new(0, 0.1)
  # @mover.apply_force(gravity)
  # Shake force
  # @mover.shake
  # Boundary force
  if @mover.location.x > width - 50
    boundary = Vec2D.new(-1, 0)
    @mover.apply_force(boundary)
  elsif @mover.location.x < 50
    boundary = Vec2D.new(1, 0)
    @mover.apply_force(boundary)
  end
  @mover.update
  @mover.display
  # @mover.check_edges(width, height)
end

# Instant Force
def mouse_pressed
  cannon = Vec2D.new(rand, rand)
  cannon *= 5
  @mover.apply_force(cannon)
end

def settings
  size(640, 360)
end

