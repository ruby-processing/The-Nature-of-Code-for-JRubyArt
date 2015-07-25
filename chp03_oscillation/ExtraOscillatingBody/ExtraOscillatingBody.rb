# ExtraOscillatingBody
# The Nature of Code
# http://natureofcode.com

class Mover
  attr_reader :location, :mass

  def initialize
    @location = Vec2D.new(400, 50)
    @velocity = Vec2D.new(1, 0)
    @acceleration = Vec2D.new(0, 0)
    @mass = 1
  end

  def apply_force(force)
    f = force / @mass
    @acceleration += f
  end

  def update
    @velocity += @acceleration
    @location += @velocity
    @acceleration *= 0
  end

  def display
    stroke(0)
    stroke_weight(2)
    fill(127)
    push_matrix
    translate(@location.x, @location.y)
    heading = -1 * Math.atan2(-@velocity.y, @velocity.x)
    rotate(heading)
    ellipse(0, 0, 16, 16)
    rect_mode(CENTER)
    # "20" should be a variable that is oscillating with sine function
    rect(20, 0, 10, 10)
    pop_matrix
  end

  def check_edges(width, height)
    if @location.x > width
      @location.x = 0
    elsif @location.x < 0
      @location.x = width
    end

    if @location.y > height
      @velocity.y *= -1
      @location.y = height
    end
  end
end

class Attractor

  G = 1

  def initialize(width, height)
    @location = Vec2D.new(width/2, height/2)
    @mass = 20
    @drag_offset = Vec2D.new(0.0, 0.0)
    @dragging = false
    @rollover = false
  end

  def attract(mover)
    force = @location - mover.location   # Calculate direction of force
    d = force.mag                        # Distance between objects
    d = constrain(d, 5.0, 25.0)          # Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize!                     # Normalize vector (distance doesn't matter here, we just want this vector for direction)
    strength = (G * @mass * mover.mass) / (d * d)     # Calculate gravitional force magnitude
    force *= strength                    #  Get force vector --> magnitude * direction
    force
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
  def clicked(mx, my)
    d = dist(mx, my, @location.x, @location.y)
    if d < @mass
      @dragging = true
      @drag_offset.x = @location.x - mx
      @drag_offset.y = @location.y - my
    end
  end

  def hover(mx, my)
    d = dist(mx, my, @location.x, @location.y)
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
  @a = Attractor.new(width, height)
end

def draw
  background(255)

  force = @a.attract(@m)
  @m.apply_force(force)
  @m.update

  @a.drag
  @a.hover(mouse_x, mouse_y)

  @a.display
  @m.display
end

def mouse_pressed
  @a.clicked(mouse_x, mouse_y)
end

def mouse_released
  @a.stop_dragging
end

def settings
  size(640, 360)
end

