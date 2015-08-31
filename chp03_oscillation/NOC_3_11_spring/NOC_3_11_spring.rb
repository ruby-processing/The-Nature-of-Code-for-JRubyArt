# NOC_3_11_spring
# The Nature of Code
# http://natureofcode.com

class Bob
  attr_accessor :location, :velocity

  def initialize(x, y)
    @location = Vec2D.new(x,y)
    @velocity = Vec2D.new
    @acceleration = Vec2D.new
    @drag_offset = Vec2D.new
    @dragging = false
    @damping = 0.98 # Arbitrary damping to simulate friction / drag
    @mass = 24
  end

  # Standard Euler integration
  def update
    @velocity += @acceleration
    @velocity *= @damping
    @location += @velocity
    @acceleration *= 0
  end

  # Newton's law: F = M * A
  def apply_force(force:)
    f = force / @mass
    @acceleration += f
  end

  # Draw the bob
  def display
    stroke(0)
    stroke_weight(2)
    fill(175)
    fill(50) if @dragging
    ellipse(@location.x, @location.y, @mass*2, @mass*2)
  end

  # This checks to see if we clicked on the mover
  def clicked(mx, my)
    d = dist(mx, my, @location.x, @location.y)
    if d < @mass
      @dragging = true
      @drag_offset.x = @location.x-mx
      @drag_offset.y = @location.y-my
    end
  end

  def stop_dragging
    @dragging = false
  end

  def drag(mx, my)
    if @dragging
      @location.x = mx + @drag_offset.x
      @location.y = my + @drag_offset.y
    end
  end
end

# Class to describe an anchor point that can connect to "Bob" objects via a spring
# Thank you: http://www.myphysicslab.com/spring2d.html

class Spring

  def initialize(origin:, length:)
    @anchor = origin
    @len = length
    @k = 0.2
  end

  # Calculate spring force
  def connect(bob)
    # Vector pointing from anchor to bob location
    attraction = bob.location - @anchor
    d = attraction.mag
    # Stretch is difference between current distance and rest length
    stretch = d - @len

    # Calculate force according to Hooke's Law
    # F = k * stretch
    attraction.normalize!
    attraction *= -1 * @k * stretch
    bob.apply_force(force: attraction)
  end

  # Constrain the distance between bob and anchor between min and max
  def constrain_length(bob, minlen, maxlen)
    dir = bob.location - @anchor
    d = dir.mag
    # Is it too short?
    if d < minlen
      dir.normalize!
      dir *= minlen
      # Reset location and stop from moving (not realistic physics)
      bob.location = @anchor + dir
      bob.velocity *= 0
    elsif d > maxlen # is it too long?
      dir.normalize!
      dir *= maxlen
      # Reset location and stop from moving (not realistic physics)
      bob.location = @anchor + dir
      bob.velocity *= 0
    end
  end

  def display
    stroke(0)
    fill(175)
    stroke_weight(2)
    rect_mode(CENTER)
    rect(@anchor.x, @anchor.y, 10, 10)
  end

  def display_line(bob)
    stroke_weight(2)
    stroke(0)
    line(bob.location.x, bob.location.y, @anchor.x, @anchor.y)
  end
end

# NOC_3_11_spring
def setup
  sketch_title 'Spring'
  @spring = Spring.new(origin: Vec2D.new(width/2, 10), length: 100)
  @bob = Bob.new(width/2, 100)
end

def draw
  background(255)
  # Apply a gravity force to the bob
  gravity = Vec2D.new(0,2)
  @bob.apply_force(force: gravity)

  # Connect the bob to the spring (this calculates the force)
  @spring.connect(@bob)
  # Constrain spring distance between min and max
  @spring.constrain_length(@bob, 30, 200)

  @bob.update
  # If it's being dragged
  @bob.drag(mouse_x, mouse_y)

  # Draw everything
  @spring.display_line(@bob) # Draw a line between spring and bob
  @bob.display
  @spring.display

  fill(0)
  text('click on bob to drag', 10, height - 5)
end

def mouse_pressed
  @bob.clicked(mouse_x, mouse_y)
end

def mouse_released
  @bob.stop_dragging
end

def settings
  size(640, 360)
end

