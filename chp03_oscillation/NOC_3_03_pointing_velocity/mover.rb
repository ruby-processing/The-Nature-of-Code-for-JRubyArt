class Mover
  include Processing::Proxy
  attr_reader :location, :mass, :velocity

  def initialize(location:)
    @location = location
    @velocity = Vec2D.new
    @topspeed = 4
    @xoff = 1_000
    @yoff = 0
  end

  def update(mouse:)
    dir = mouse - location
    dir.normalize!
    dir *= 0.5
    @velocity += dir
    @velocity.set_mag(@topspeed) { velocity.mag > @topspeed }
    @location += velocity
  end

  def display
    theta = velocity.heading
    stroke(0)
    stroke_weight(2)
    fill(127)
    push_matrix
    rect_mode(CENTER)
    translate(location.x, location.y)
    rotate(theta)
    rect(0, 0, 30, 10)
    pop_matrix
  end

  def check_edges(max_x:, max_y:)
    if location.x > max_x
      location.x = 0
    elsif location.x < 0
      location.x = max_x
    end
    if location.y > max_y
      location.y = 0
    elsif location.y < 0
      location.y = max_y
    end
  end
end
