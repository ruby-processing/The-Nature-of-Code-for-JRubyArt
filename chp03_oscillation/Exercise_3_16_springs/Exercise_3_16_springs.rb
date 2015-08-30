# Exercise_3_16_springs
# Blob class just like our regular Mover class
class Bob
  attr_reader :location, :mass

  def initialize(location:)
    @location = location
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
    ellipse(location.x, location.y, mass * 2, mass * 2)
  end

  # This checks to see if we clicked on the mover
  def clicked(position:)
    d = position.dist(location)
    return unless d < mass
    @dragging = true
    @drag_offset = location - position
  end

  def stop_dragging
    @dragging = false
  end

  def drag(position:)
    return unless @dragging
    @location = position + @drag_offset
  end
end

# Class to describe an anchor point that can connect to "Bob" objects via a spring
# Thank you: http://www.myphysicslab.com/spring2d.html
class Spring

  def initialize(bob_a:, bob_b:, length:)
    @bob_a = bob_a
    @bob_b = bob_b
    @len = length
    @k = 0.2
  end

  # Calculate spring force
  def update
    # Vector pointing from anchor to bob location
    spring_force = @bob_a.location - @bob_b.location
    # What is distance
    d = spring_force.mag
    # Stretch is difference between current distance and rest length
    stretch = d - @len

    # Calculate force according to Hooke's Law
    # F = k * stretch
    spring_force.normalize!
    spring_force *= -1 * @k * stretch
    @bob_a.apply_force(force: spring_force)
    spring_force *= -1
    @bob_b.apply_force(force: spring_force)
  end

  def display
    stroke_weight(2)
    stroke(0)
    line(@bob_a.location.x, @bob_a.location.y, @bob_b.location.x, @bob_b.location.y)
  end
end

# Exercise_3_16_springs
def setup
  sketch_title 'Springs Exercise'
  # Create objects at starting location
  # Note third argument in Spring constructor is "rest length"
  b1 = Bob.new(location: Vec2D.new(width / 2, 100))
  b2 = Bob.new(location: Vec2D.new(width / 2, 200))
  b3 = Bob.new(location: Vec2D.new(width / 2, 300))
  s1 = Spring.new(bob_a: b1, bob_b: b2, length: 100)
  s2 = Spring.new(bob_a: b2, bob_b: b3, length: 100)
  s3 = Spring.new(bob_a: b1, bob_b: b3, length: 100)
  @bobs = [b1, b2, b3]
  @springs = [s1, s2, s3]
end

def draw
  background(255)
  @springs.each(&:update)
  @springs.each(&:display)
  @bobs.each do |b|
    b.update
    b.display
  end
  @bobs[0].drag(position: Vec2D.new(mouse_x, mouse_y))
end

def mouse_pressed
  @bobs[0].clicked(position: Vec2D.new(mouse_x, mouse_y))
end

def mouse_released
  @bobs[0].stop_dragging
end

def settings
  size(640, 360)
end
