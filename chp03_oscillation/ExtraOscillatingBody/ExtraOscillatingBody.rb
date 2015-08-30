# ExtraOscillatingBody
# The Nature of Code
# http://natureofcode.com
class Mover
  attr_reader :location, :mass, :velocity

  def initialize
    @location = Vec2D.new(400, 50)
    @velocity = Vec2D.new(1, 0)
    @acceleration = Vec2D.new(0, 0)
    @mass = 1
  end

  def apply_force(force:)
    f = force / @mass
    @acceleration += f
  end

  def update
    @velocity += @acceleration
    @location += velocity
    @acceleration *= 0
  end

  def display
    stroke(0)
    stroke_weight(2)
    fill(127)
    push_matrix
    translate(location.x, location.y)
    rotate(velocity.heading)
    ellipse(0, 0, 16, 16)
    rect_mode(CENTER)
    # "20" should be a variable that is oscillating with sine function
    rect(20, 0, 10, 10)
    pop_matrix
  end

  def check_edges(width, height)
    if location.x > width
      location.x = 0
    elsif location.x < 0
      location.x = width
    end
    return unless location.y > height
    velocity.y *= -1
    location.y = height
  end
end

class Attractor
  G = 1

  def initialize(location:)
    @location = location
    @mass = 20
    @drag_offset = Vec2D.new(0.0, 0.0)
    @dragging = false
    @rollover = false
  end

  def attract(mover)
    attraction = @location - mover.location   # Calculate direction of force
    d = attraction.mag                        # Distance between objects
    d = constrain(d, 5.0, 25.0)          # Limiting the distance to eliminate "extreme" results for very close or very far objects
    attraction.normalize!                     # Normalize vector (distance doesn't matter here, we just want this vector for direction)
    strength = (G * @mass * mover.mass) / (d * d)     # Calculate gravitional force magnitude
    attraction *= strength                    #  Get force vector --> magnitude * direction
  end

  # Method to display
  def display
    ellipse_mode(CENTER)
    stroke_weight(4)
    stroke(0)
    if @dragging
      fill(50)
    elsif @rollover
      fill(100)
    else
      fill(175, 200)
    end
    ellipse(@location.x, @location.y, @mass * 2, @mass * 2)
  end

  # The methods below are for mouse interaction
  def clicked(position:)
    d = position.dist(@location)
    return unless d < @mass
    @dragging = true
    @drag_offset = @location -  position
  end

  def hover(position:)
    d = position.dist(@location)
    @rollover = (d < @mass)
  end

  def stop_dragging
    @dragging = false
  end

  def drag
    if @dragging
      @location.x = mouse_x + @drag_offset.x
      @location.y = mouse_y + @drag_offset.y
    end
  end
end

# ExtraOscillatingBody
def setup
  sketch_title 'Extra Oscillating Body'
  @m = Mover.new
  @a = Attractor.new(location: Vec2D.new(width/2, height/2))
end

def draw
  background(255)
  attraction = @a.attract(@m)
  @m.apply_force(force: attraction)
  @m.update

  @a.drag
  @a.hover(position: Vec2D.new(mouse_x, mouse_y))

  @a.display
  @m.display
end

def mouse_pressed
  @a.clicked(position: Vec2D.new(mouse_x, mouse_y))
end

def mouse_released
  @a.stop_dragging
end

def settings
  size(640, 360)
end
