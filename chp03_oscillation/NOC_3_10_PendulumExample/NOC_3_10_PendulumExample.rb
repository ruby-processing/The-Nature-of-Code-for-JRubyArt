# NOC_3_10_PendulumExample
# The Nature of Code
# http://natureofcode.com

# A Simple Pendulum Class
# Includes functionality for user can click and drag the pendulum

class Pendulum

  def initialize(origin_, r_)
    @origin = origin_.copy
    @location = Vec2D.new
    @r = r_ # length of arm
    @angle = PI / 4
    @aVelocity = 0.0
    @aAcceleration = 0.0
    @damping = 0.995   # Arbitrary damping
    @ballr = 48.0      # Arbitrary ball radius
    @dragging = false
  end

  def go
    update
    drag
    display
  end

  def update
    # As long as we aren't dragging the pendulum, let it swing!
    return if @dragging # using guard clause in place of conditional
    gravity = 0.4                              # Arbitrary constant
    # Calculate acceleration (see: http://www.myphysicslab.com/pendulum1.html)
    @aAcceleration = (-1 * gravity / @r) * sin(@angle)
    @aVelocity += @aAcceleration               # Increment velocity
    @aVelocity *= @damping                     # Arbitrary damping
    @angle += @aVelocity                       # Increment angle
  end

  def display
    # Polar to cartesian conversion
    @location = Vec2D.new(@r * sin(@angle), @r * cos(@angle))
    @location += @origin # Set location relative to the pendulum's origin
    stroke(0)
    stroke_weight(2)
    # Draw the arm
    line(@origin.x, @origin.y, @location.x, @location.y)
    ellipse_mode(CENTER)
    fill(175)
    fill(0) if @dragging
    # Draw the ball
    ellipse(@location.x, @location.y, @ballr, @ballr)
  end

  def clicked(mx, my)
    d = dist(mx, my, @location.x, @location.y)
    @dragging = true if d < @ballr
  end

  # This tells us we are not longer clicking on the ball
  def stop_dragging
    @aVelocity = 0 # No velocity once you let go
    @dragging = false
  end

  def drag
    # If we are draging the ball, we calculate the angle between the
    # pendulum origin and mouse location
    # we assign that angle to the pendulum
    if @dragging
      diff = @origin - Vec2D.new(mouse_x, mouse_y)
      @angle = atan2(-1 * diff.y, diff.x) - PI / 2 # Relative to vertical axis
    end
  end
end

# NOC_3_10_PendulumExample
def setup
  sketch_title 'Noc 3 10 Pendulum Example'
  # Make a new Pendulum with an origin location and armlength
  @p = Pendulum.new(Vec2D.new(width/2, 0), 175)
end

def draw
  background(255)
  @p.go
end

def mouse_pressed
  @p.clicked(mouse_x, mouse_y)
end

def mouse_released
  @p.stop_dragging
end

def settings
  size(800, 200)
end

