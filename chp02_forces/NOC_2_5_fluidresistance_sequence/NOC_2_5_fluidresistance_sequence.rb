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
    ((@x .. @x + @w).include? l.x) && ((@y .. @y + @h).include? l.y)
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
    drag_force.set_mag(drag_magnitude)
    drag_force
  end

  def display
    no_stroke()
    fill(50)
    rect(@x, @y, @w, @h)
  end
end

class Mover
  attr_reader :mass, :velocity, :location
  def initialize(mass, x, y)
    @location = Vec2D.new(x, y)
    @velocity = Vec2D.new(0, 0)
    @acceleration = Vec2D.new(0, 0)
    @mass = mass
  end

  def apply_force(force)
    @acceleration += force / mass
  end

  def update
    @velocity += @acceleration
    @location += @velocity
    @acceleration *= 0
  end

  def display
    stroke(0)
    stroke_weight(2 * 2.5)
    fill(127, 200)
    ellipse(@location.x, @location.y, @mass * 16, @mass * 16)
  end

  # bounce off the bottom of the window
  def check_edges(height)
    if @location.y > height
      @velocity.y *= -0.9  # A little dampening when hitting the bottom
      @location.y = height
    end
  end
end

# NOC_2_5_fluidresistance_sequence
# Forces (Gravity and Fluid Resistence) with Vectors

# Demonstration of multiple force acting on bodies (Mover class)
# Bodies experience gravity continuously
# Bodies experience fluid resistance when in "water"

def setup
  sketch_title 'Noc 2 5 Fluidresistance Sequence'
  srand(1)
  reset!
  @liquid = Liquid.new(0, height/2, width, height/2, 0.1)
end

def draw
  background(255)
  # Draw water
  @liquid.display
  @movers.each do |m|
    # Is the Mover in the liquid?
    if @liquid.contains(m)
      # Calculate drag force
      drag_force = @liquid.drag(m)
      # Apply drag force to Mover
      m.apply_force(drag_force)
    end
    # Gravity is scaled by mass here!
    gravity = Vec2D.new(0, 0.1 * m.mass)
    m.apply_force(gravity)
    # Update and display
    m.update
    m.display
    m.check_edges(height)
  end
  fill(0)
  save_frame("ch2_05_####.png") if frame_count % 20 == 0
end

def mouse_pressed
  reset!
end

# Restart all the Mover objects randomly
def reset!
  @movers = Array.new(5)
  @movers.each_index do |i|
    @movers[i] = Mover.new(rand(0.5 * 2.25 .. 3 * 2.25), 20 * 2.25 + i * 40 * 2.25, 0)
  end
end

def settings
  size(640, 360)
end

