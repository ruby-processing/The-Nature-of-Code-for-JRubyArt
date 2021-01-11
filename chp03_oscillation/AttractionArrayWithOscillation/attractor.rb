# AttractionArrayWithOscillation
# The Nature of Code
# http://natureofcode.com

# Attraction Array with Oscillating objects around each thing
class Attractor
  include Processing::Proxy
  attr_reader :rollover, :location, :mass, :gravity

  def initialize(location:, mass:, gravity:)
    @location = location
    @mass = mass
    @gravity = gravity
    @drag = Vec2D.new(0.0, 0.0)
    @dragging = false
    @rollover = false
  end

  def attract(crawler:)
    dir = @location - crawler.loc    # Calculate direction of force
    d = dir.mag                      # Distance between objects
    # Limit the distance to eliminate "extremes"
    d = constrain(d, 5.0, 25.0)
    dir.normalize! # Normalize vector for direction
    # Calculate gravitional force magnitude
    force = (gravity * mass * crawler.mass) / (d * d)
    dir *= force # force vector --> magnitude * direction
    dir
  end

  # Method to display
  def render
    ellipse_mode(CENTER)
    stroke 0, 100
    if @dragging
      fill 50
    elsif rollover
      fill 100
    else
      fill 175, 50
    end
    ellipse(@location.x, @location.y, mass * 2, mass * 2)
  end

  # The methods below are for mouse interaction
  def clicked(position:)
    d = position.dist(location)
    return unless d < mass

    @dragging = true
    @drag_offset = location - position
  end

  def stop_dragging
    @dragging = false
  end

  def move(position: Vec2D.new(mouse_x, mouse_y))
    hover(position)
    drag(position)
    render
  end

  private

  # Method to display
  def render
    ellipse_mode(CENTER)
    stroke 0, 100
    if @dragging
      fill 50
    elsif rollover
      fill 100
    else
      fill 175, 50
    end
    ellipse(@location.x, @location.y, mass * 2, mass * 2)
  end

  def hover(pos)
    d = pos.dist(location)
    @rollover = d < mass
  end

  def drag(pos)
    return unless @dragging

    @location = pos + @drag_offset
  end
end
