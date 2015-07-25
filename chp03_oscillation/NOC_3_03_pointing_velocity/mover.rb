class Mover
  include Processing::Proxy
  attr_reader :location, :mass, :velocity, :width, :height

  def initialize(x, y)
    @width, @height = x * 2, y * 2
    @location = Vec2D.new(x, y)
    @velocity = Vec2D.new
    @topspeed = 4
    @xoff = 1_000
    @yoff = 0
  end

  def update
    mouse = Vec2D.new(mouse_x, mouse_y)
    dir = mouse - location
    dir.normalize!
    dir *= 0.5
    @velocity += dir
    @velocity.set_mag(@topspeed) {velocity.mag > @topspeed}
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

  def check_edges
    if location.x > width
      location.x = 0
    elsif location.x < 0
      location.x = width
    end

    if location.y > height
      location.y = 0
    elsif location.y < 0
      location.y = height
    end
  end
end
