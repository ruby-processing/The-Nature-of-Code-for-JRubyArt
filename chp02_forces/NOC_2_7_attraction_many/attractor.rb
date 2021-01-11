# frozen_string_literal: true

# NOC_2_7_attraction_many
# The Nature of Code
# http://natureofcode.com
# A class for a draggable attractive body in our world
class Attractor
  include Processing::Proxy
  G = 1
  attr_reader :location, :mass

  def initialize(location:)
    @location = location
    @mass = 20
    @drag_offset = Vec2D.new
    @dragging = false
    @rollover = false
  end

  def attract(mover:)
    # Calculate direction of force
    force = location - mover.location
    # Distance between objects
    dist = force.mag
    # Limit the dististance to avoid "extreme" results
    dist = constrain(dist, 5.0, 25.0)
    # Normalize vector, we just want the vector direction
    force.normalize!
    # Calculate magnitude of gravitional force
    strength = (G * mass * mover.mass) / (dist * dist)
    force *= strength # Calculate force vector --> magnitude * direction
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
    ellipse(@location.x, @location.y, mass * 2, mass * 2)
  end

  # The methods below are for mouse interaction
  def clicked(position:)
    dist = position.dist(location)
    return unless dist < @mass

    @dragging = true
    @drag_offset = location - position
  end

  def hover(position:)
    dist = position.dist(location)
    @rollover = dist < @mass
  end

  def stop_dragging
    @dragging = false
  end

  def drag(position:)
    return unless @dragging

    @location = position + @drag_offset
  end
end
