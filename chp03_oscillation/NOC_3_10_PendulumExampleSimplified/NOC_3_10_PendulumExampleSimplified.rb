# NOC_3_10_PendulumExampleSimplified

class Pendulum
  attr_reader :angle, :origin, :location
  def initialize(origin_, r_)
    @origin = origin_
    @location = Vec2D.new
    @r = r_ # length of arm
    @angle = PI / 4
    @aVelocity = 0.0
    @aAcceleration = 0.0
    @damping = 0.995   # Arbitrary damping
  end

  def go
    update
    display
  end

  def update
    gravity = 0.4                                # Arbitrary constant
    # Calculate acceleration (see: http://www.myphysicslab.com/pendulum1.html)
    @aAcceleration = (-1 * gravity / @r) * sin(angle)
    @aVelocity += @aAcceleration                 # Increment velocity
    @aVelocity *= @damping                       # Arbitrary damping
    @angle += @aVelocity                         # Increment angle
  end

  def display
    # Polar to cartesian conversion
    @location = Vec2D.new(@r * sin(angle), @r * cos(angle))
    @location += origin # Set the location is relative to the pendulum's origin
    stroke(0)
    stroke_weight(2)
    # Draw the arm
    line(origin.x, origin.y, location.x, location.y)
    ellipse_mode(CENTER)
    fill(175)
    # Draw the ball
    ellipse(location.x, location.y, 48, 48)
  end
end

# NOC_3_10_PendulumExampleSimplified
def setup
  sketch_title 'Noc 3 10 Pendulum Example Simplified'
  # Make a new Pendulum with an origin location and armlength
  @p = Pendulum.new(Vec2D.new(width / 2, 0), 175)
end

def draw
  background(255)
  @p.go
end

def settings
  size(800, 200)
  smooth 4
end

