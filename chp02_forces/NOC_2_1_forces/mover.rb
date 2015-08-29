class Mover
  include Processing::Proxy
  RADIUS = 24
  def initialize
    @location = Vec2D.new(30, 30)
    @velocity = Vec2D.new
    @acceleration = Vec2D.new
    @mass = 1
  end

  def apply_force(force:)
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
    fill(127)
    ellipse(@location.x, @location.y, 2 * RADIUS, 2 * RADIUS)
  end

  def check_edges(max_x:, max_y:)
    xmax = max_x - RADIUS
    ymax = max_y - RADIUS
    if @location.x > xmax
      @location.x = xmax
      @velocity.x *= -1
    elsif @location.x < RADIUS
      @location.x = RADIUS
      @velocity.x *= -1
    end
    if @location.y > ymax
      @location.y = ymax
      @velocity.y *= -1
    elsif @location.y < RADIUS
      @location.y = RADIUS
      @velocity.y *= -1
    end
  end
end
