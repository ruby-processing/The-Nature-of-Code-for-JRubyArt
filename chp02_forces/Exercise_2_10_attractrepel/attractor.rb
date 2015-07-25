class Attractor
  include Processing::Proxy

  attr_reader :mass, :location
  def initialize(width, height)
    @location = Vec2D.new(width/2, height/2)
    @mass = 10
    @drag_offset = Vec2D.new(0.0, 0.0)
    @dragging = false
    @rollover = false
  end

  def attract(mover)
    force = location - mover.location             # Calculate direction of force
    d = force.mag                                  # Distance between objects
    d = constrain(d, 5.0, 25.0)                    # Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize!                               # Normalize vector (distance doesn't matter here, we just want this vector for direction)
    strength = (G * mass * mover.mass) / (d * d)  # Calculate gravitional force magnitude
    force *= strength                              # Get force vector --> magnitude * direction
    force
  end

  def display
    ellipse_mode CENTER
    stroke 0
    if @dragging
      fill 50
    elsif @rollover
      fill 100
    else
      fill 0
    end
    ellipse(location.x, location.y, mass * 6, mass * 6)
  end

  # The methods below are for mouse interaction
  def clicked(mx, my)
    d = dist(mx ,my, location.x, location.y)
    if d < @mass
      @dragging = true;
      @drag_offset.x = location.x - mx
      @drag_offset.y = location.y - my
    end
  end

  def hover(mx, my)
    d = dist(mx, my, location.x, location.y)
    @rollover = d <  mass
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


