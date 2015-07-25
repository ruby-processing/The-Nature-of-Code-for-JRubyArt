# NOC_2_7_attraction_many
# The Nature of Code
# http://natureofcode.com
# A class for a draggable attractive body in our world

class Attractor
  include Processing::Proxy
  G = 1
  def initialize(width, height)
    @location = Vec2D.new(width / 2, height / 2)
    @mass = 20
    @drag_offset = Vec2D.new
    @dragging = false
    @rollover = false
  end

  def attract(mover)
    force = @location - mover.location           # Calculate direction of force
    d = force.mag                                # Distance between objects
    d = constrain(d, 5.0, 25.0)                  # Limiting the distance to eliminate "extreme" results for very close or very far objects
    strength = (G * @mass * mover.mass) / (d * d)# Calculate gravitional force magnitude
    force.set_mag strength                         # Get force vector --> magnitude * direction
    force
  end

  def display
    ellipse_mode CENTER
    stroke_weight 4
    stroke 0
    if @dragging
      fill 50
    elsif @rollover
      fill 100
    else
      fill 175, 200
    end
    ellipse(@location.x, @location.y, @mass*2, @mass*2)
  end

  # The methods below are for mouse interaction
  def clicked(mx, my)
    d = dist(mx ,my, @location.x, @location.y)
    if d < @mass
      @dragging = true;
      @drag_offset.x = @location.x - mx
      @drag_offset.y = @location.y - my
    end
  end

  def hover(mx, my)
    d = dist(mx, my, @location.x, @location.y)
    @rollover = d < @mass
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

class Mover
  attr_reader :mass, :velocity, :location
  def initialize(x, y, m)
    @location = Vec2D.new(x, y)
    @velocity = Vec2D.new(1, 0)
    @acceleration = Vec2D.new(0, 0)
    @mass = m
  end

  def apply_force(force)
    @acceleration += force / @mass
  end

  def update
    @velocity += @acceleration
    @location += @velocity
    @acceleration *= 0
  end

  def display
    stroke(0)
    stroke_weight(2)
    fill(0, 100)
    ellipse(@location.x, @location.y, @mass*25, @mass*25)
  end
end


# NOC_2_7_attraction_many
def setup
  sketch_title 'Attractor'
  @movers = Array.new(10) { Mover.new(rand(width), rand(height), rand(0.1 .. 2)) }
  @attractor = Attractor.new(width, height)
end

def draw
  background(255)
  @attractor.display
  @attractor.drag
  @attractor.hover(mouse_x, mouse_y)
  @movers.each do |m|
    force = @attractor.attract(m)
    m.apply_force(force)
    m.update
    m.display
  end
end

def mouse_pressed
  @attractor.clicked(mouse_x, mouse_y)
end

def mouse_released
  @attractor.stop_dragging
end

def settings
  size(640, 360)
end

