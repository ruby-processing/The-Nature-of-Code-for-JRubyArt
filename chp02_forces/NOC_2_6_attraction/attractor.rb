#  NOC_2_6_attraction
# The Nature of Code
# http://natureofcode.com
# A class for a draggable attractive body in our world
class Attractor
  include Processing::Proxy
  attr_reader :acceleration, :location, :mass
  G = 1

  def initialize(location:)
    @location = location
    @mass = 20
    @drag_offset = Vec2D.new(0.0, 0.0)
    @dragging = false
    @rollover = false
  end

  def attract(mover:)
    # Calculate direction of force
    force = location - mover.location
    force.tap do |f|
      # Distance between objects
      d = f.mag
      # Limit the distance to avoid "extreme" results
      d = constrain(d, 5.0, 25.0)
      # Normalize vector, we just want the vector direction
      f.normalize!
      # Calculate magnitude of gravitional force
      strength = (G * mass * mover.mass) / (d * d)
      f *= strength # Calculate force vector --> magnitude * direction
    end
  end

  # def attract(mover:)
  #   # Calculate direction of force
  #   force = location - mover.location
  #   # Distance between objects
  #   d = force.mag
  #   # Limit the distance to avoid "extreme" results
  #   d = constrain(d, 5.0, 25.0)
  #   # Normalize vector, we just want the vector direction
  #   force.normalize!
  #   # Calculate magnitude of gravitional force
  #   strength = (G * mass * mover.mass) / (d * d)
  #   force *= strength # Calculate force vector --> magnitude * direction
  #   force
  # end

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
    ellipse(location.x, location.y, mass * 2, mass * 2)
  end

  # The methods below are for mouse interaction
  def clicked(position:)
    d = position.dist(location)
    return unless d < @mass
    @dragging = true
    @drag_offset = location - position
  end

  def hover(position:)
    d = position.dist(location)
    @rollover = d < @mass
  end

  def stop_dragging
    @dragging = false
  end

  def drag(position:)
    return unless @dragging
    @location = position + @drag_offset
  end
end
