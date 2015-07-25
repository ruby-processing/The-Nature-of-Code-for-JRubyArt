# AttractionArrayWithOscillation
# The Nature of Code
# http://natureofcode.com

# Attraction Array with Oscillating objects around each thing

class Oscillator

  def initialize(r)
    @theta = 0
    @amplitude = r
  end

  def update(angle)
    @theta += angle
  end

  def display
    x = map1d(cos(@theta), (-1 .. 1.0), (0 .. @amplitude))
    stroke(0)
    fill(50)
    line(0, 0, x, 0)
    ellipse(x, 0, 8, 8)
  end
end

class Crawler
  attr_reader :loc, :mass, :acc, :vel

  def initialize(width, height)
    @acc = Vec2D.new
    @vel = Vec2D.new(rand(-1.0 .. 1), rand(-1.0 .. 1))
    @loc = Vec2D.new(rand(width), rand(height))
    @mass = rand(8.0 ..  16)
    @osc = Oscillator.new(mass * 2)
  end

  def apply_force(force)
    f = force.copy
    f /= mass
    @acc += f
  end

  # Method to update location
  def update
    @vel += acc
    @loc += vel
    # Multiplying by 0 sets the all the components to 0
    @acc *= 0

    @osc.update(vel.mag / 10)
  end

  # Method to display
  def display
    angle = vel.heading
    push_matrix
    translate(loc.x, loc.y)
    rotate(angle)
    ellipse_mode(CENTER)
    stroke(0)
    fill(175, 100)
    ellipse(0, 0, mass * 2, mass * 2)
    @osc.display
    pop_matrix
  end
end

class Attractor

  def initialize(opts = {})
    @loc = opts[:location].copy
    @mass = opts[:mass]
    @g = opts[:force]
    @drag = Vec2D.new(0.0, 0.0)
    @dragging = false
    @rollover = false
  end

  def go
    render
    drag
  end

  def attract(crawler)
    dir = @loc - crawler.loc                      # Calculate direction of force
    d = dir.mag                                   # Distance between objects
    d = constrain(d, 5.0, 25.0)                   # Limiting the distance to eliminate "extreme" results for very close or very far objects
    dir.normalize!                                # Normalize vector (distance doesn't matter here, we just want this vector for direction)
    force = (@g * @mass * crawler.mass) / (d * d) # Calculate gravitional force magnitude
    dir *= force                                  # Get force vector --> magnitude * direction
    dir
  end

  # Method to display
  def render
    ellipse_mode(CENTER)
    stroke 0, 100
    if @dragging
      fill 50
    elsif @rollover
      fill 100
    else
      fill 175, 50
    end
    ellipse(@loc.x, @loc.y, @mass * 2, @mass * 2)
  end

  # The methods below are for mouse interaction
  def clicked(mx, my)
    d = dist(mx, my, @loc.x, @loc.y)
    if d < @mass
      @dragging = true
      @drag.x = @loc.x - mx
      @drag.y = @loc.y - my
    end
  end

  def rollover(mx, my)
    d = dist(mx, my, @loc.x, @loc.y)
    @rollover = d < @mass
  end

  def stop_dragging
    @dragging = false
  end

  def drag
    if @dragging
      @loc.x = mouse_x + @drag.x
      @loc.y = mouse_y + @drag.y
    end
  end
end

# AttractionArrayWithOscillation
def setup
  sketch_title 'Attraction Array With Oscillation'
  # Some rand bodies
  @crawlers = Array.new(5){ Crawler.new(width, height) }
  # Create an attractive body
  @a = Attractor.new(location: Vec2D.new(width / 2, height / 2), mass: 20, force: 0.4)
end

def draw
  background(255)
  @a.rollover(mouse_x,mouse_y)
  @a.go

  @crawlers.each do |c|
    f = @a.attract(c)
    c.apply_force(f)
    c.update
    c.display
  end
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

