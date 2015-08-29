# NOC_2_5_fluidresistance_sequence
# The Nature of Code
# http://natureofcode.com
class Liquid
  # Coefficient of drag
  def initialize(x, y, w, h, c)
    @x, @y, @w, @h, @c = x, y, w, h, c
  end

  # Is the Mover in the Liquid?
  def contains(mover)
    l = mover.location
    ((@x..@x + @w).cover? l.x) && ((@y..@y + @h).cover? l.y)
  end

  # Calculate drag force
  def drag(mover)
    # Magnitude is coefficient * speed squared
    speed = mover.velocity.mag
    drag_magnitude = @c * speed * speed
    # Direction is inverse of velocity
    drag_force = mover.velocity.copy
    drag_force *= -1
    # Scale according to magnitude
    # dragForce.setMag(dragMagnitude)
    drag_force.set_mag drag_magnitude
    drag_force
  end

  def display
    no_stroke
    fill(50)
    rect(@x, @y, @w, @h)
  end
end

# The Mover class
class Mover
  attr_reader :acceleration, :location, :mass, :radius, :velocity
  def initialize(mass:, location:)
    @location = location
    @velocity = Vec2D.new(0, 0)
    @acceleration = Vec2D.new(0, 0)
    @mass = mass
    @radius = mass * 8
  end

  def apply_force(force:)
    @acceleration += force / mass
  end

  def update
    @velocity += acceleration
    @location += velocity
    @acceleration *= 0
  end

  def display
    stroke(0)
    stroke_weight(2)
    fill(127, 200)
    ellipse(location.x, location.y, radius * 2, radius * 2)
  end

  # bounce off the bottom of the window
  def check_edges(max_y:)
    return if location.y < max_y - radius
    @velocity.y *= -0.9  # A little dampening when hitting the bottom
    @location.y = max_y - radius
  end
end

# NOC_2_5_fluidresistance_sequence
# Forces (Gravity and Fluid Resistence) with Vectors

# Demonstration of multiple force acting on bodies (Mover class)
# Bodies experience gravity continuously
# Bodies experience fluid resistance when in "water"
attr_reader :liquid, :movers

def setup
  sketch_title 'Fluid Resistance Sequence'
  srand(1)
  reset!
  @liquid = Liquid.new(0, height / 2, width, height / 2, 0.1)
end

def draw
  background(255)
  # Draw water
  liquid.display
  movers.each do |m|
    # Is the Mover in the liquid?
    if @liquid.contains(m)
      # Calculate drag force
      drag_force = liquid.drag(m)
      # Apply drag force to Mover
      m.apply_force(force: drag_force)
    end
    # Gravity is scaled by mass here!
    gravity = Vec2D.new(0, 0.1 * m.mass)
    m.apply_force(force: gravity)
    # Update and display
    m.update
    m.display
    m.check_edges(max_y: height)
  end
  fill(0)
  save_frame('ch2_05_####.png') if frame_count % 20 == 0
end

def mouse_pressed
  reset!
end

# Restart all the Mover objects randomly
def reset!
  @movers = (0..5).map do |i|
    Mover.new(
      mass: rand(0.5 * 2.25..3 * 2.25),
      location: Vec2D.new(20 * 2.25 + i * 40 * 2.25, 0)
    )
  end
end

def settings
  size(640, 360)
end
