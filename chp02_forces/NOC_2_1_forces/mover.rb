class Mover
  include Processing::Proxy

  def initialize
    @location = Vec2D.new(30, 30)
    @velocity = Vec2D.new
    @acceleration = Vec2D.new
    @mass = 1
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
    fill(127)
    ellipse(@location.x, @location.y, 48, 48)
  end

  def check_edges(width, height)
    if @location.x > width
      @location.x = width
      @velocity.x *= -1
    elsif @location.x < 0
      @location.x = 0
      @velocity.x *= -1
    end

    if @location.y > height
      @location.y = height
      @velocity.y *= -1
    elsif @location.y < 0
      @location.y = 0
      @velocity.y *= -1
    end
  end
end
