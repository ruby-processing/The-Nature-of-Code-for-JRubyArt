# Exercise_3_16_springs_array
class Bob
  attr_reader :acceleration, :velocity, :location

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
    @velocity += acceleration
    @velocity *= @damping
    @location += velocity
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
    ellipse(location.x, location.y, @mass * 2, @mass * 2)
  end

  # This checks to see if we clicked on the mover
  def clicked(position:)
    d = position.dist(location)
    return unless d < @mass
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
    attraction = @bob_a.location - @bob_b.location
    # What is distance
    d = attraction.mag
    # Stretch is difference between current distance and rest length
    stretch = d - @len
    # Calculate force according to Hooke's Law
    # F = k * stretch
    attraction.normalize!
    attraction *= -1 * @k * stretch
    @bob_a.apply_force(force: attraction)
    attraction *= -1
    @bob_b.apply_force(force: attraction)
  end

  def display
    stroke_weight(2)
    stroke(0)
    line(@bob_a.location.x, @bob_a.location.y, @bob_b.location.x, @bob_b.location.y)
  end
end

# Exercise_3_16_springs_array
def setup
  sketch_title 'Exercise 3 16 Springs Array'
  # Create objects at starting location
  # Note third argument in Spring constructor is "rest length"
  @bobs = (0..5).map { |i| Bob.new(location: Vec2D.new(width / 2, i * 40)) }
  @springs = (0..4).map { |i| Spring.new(@bobs[i], @bobs[i + 1], 40) }
end

def draw
  background(255)
  @springs.each do |s|
    s.update
    s.display
  end
  @bobs.each do |b|
    b.update
    b.display
    b.drag(position: Vec2D.new(mouse_x, mouse_y))
  end
end

def mouse_pressed
  @bobs.each{ |b| b.clicked(position: Vec2D.new(mouse_x, mouse_y)) }
end

def mouse_released
  @bobs.each{ |b| b.stop_dragging }
end

def settings
  size(640, 360)
end
