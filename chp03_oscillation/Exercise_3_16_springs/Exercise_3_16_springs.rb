# Exercise_3_16_springs
# Blob class just like our regular Mover class

class Bob
  attr_reader :location

  def initialize(x, y)
    @location = Vec2D.new(x,y)
    @velocity = Vec2D.new
    @acceleration = Vec2D.new
    @drag_offset = Vec2D.new
    @dragging = false
    @damping = 0.95 # Arbitrary damping to simulate friction / drag
    @mass = 12
  end

  # Standard Euler integration
  def update
    @velocity += @acceleration
    @velocity *= @damping
    @location += @velocity
    @acceleration *= 0
  end

  # Newton's law: F = M * A
  def apply_force(force)
    f = force / @mass
    @acceleration += f
  end

  # Draw the bob
  def display
    stroke(0)
    stroke_weight(2)
    fill(175)
    fill(50) if @dragging
    ellipse(@location.x, @location.y, @mass * 2, @mass * 2)
  end

  # This checks to see if we clicked on the mover
  def clicked(mx, my)
    d = dist(mx, my, @location.x, @location.y)
    if d < @mass
      @dragging = true
      @drag_offset.x = @location.x - mx
      @drag_offset.y = @location.y - my
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

  def initialize(a, b, l)
    @bob_a = a
    @bob_b = b
    @len = l
    @k = 0.2
  end

  # Calculate spring force
  def update
    # Vector pointing from anchor to bob location
    force = @bob_a.location - @bob_b.location
    # What is distance
    d = force.mag
    # Stretch is difference between current distance and rest length
    stretch = d - @len

    # Calculate force according to Hooke's Law
    # F = k * stretch
    force.normalize!
    force *= -1 * @k * stretch
    @bob_a.apply_force(force)
    force *= -1
    @bob_b.apply_force(force)
  end

  def display
    stroke_weight(2)
    stroke(0)
    line(@bob_a.location.x, @bob_a.location.y, @bob_b.location.x, @bob_b.location.y)
  end
end

# Exercise_3_16_springs
def setup
  sketch_title 'Exercise 3 16 Springs'
  # Create objects at starting location
  # Note third argument in Spring constructor is "rest length"
  b1 = Bob.new(width / 2, 100)
  b2 = Bob.new(width / 2, 200)
  b3 = Bob.new(width / 2, 300)

  s1 = Spring.new(b1, b2, 100)
  s2 = Spring.new(b2, b3, 100)
  s3 = Spring.new(b1, b3, 100)
  @bobs = [b1, b2, b3]
  @springs = [s1, s2, s3]
end

def draw
  background(255)

  @springs.each{ |s| s.update }
  @springs.each{ |s| s.display }

  @bobs.each do |b|
    b.update
    b.display
  end

  @bobs[0].drag(mouse_x, mouse_y)
end

def mouse_pressed
  @bobs[0].clicked(mouse_x, mouse_y)
end

def mouse_released
  @bobs[0].stop_dragging
end

def settings
  size(640, 360)
end

