# The Nature of Code
# NOC_6_01_Seek_trail

class Vehicle
  attr_reader :location, :velocity, :acceleration, :width, :height

  def initialize(location:, max_x:, max_y:, safe_distance:)
    @acceleration = Vec2D.new
    @velocity = Vec2D.new(3, -2)
    @location = location
    @r = 6
    @maxspeed = 3
    @maxforce = 0.15
    @width = max_x
    @height = max_y
    @d = safe_distance
  end

  def run
    update
    display
  end

  def apply_force(force:)
    @acceleration += force
  end

  def update
    @velocity += acceleration
    @velocity.set_mag(@maxspeed) { velocity.mag > @maxspeed }
    @location += velocity
    @acceleration *= 0
  end

  def boundaries
    desired = if location.x < @d
                Vec2D.new(@maxspeed, velocity.y)
              elsif location.x > width - @d
                Vec2D.new(-@maxspeed, velocity.y)
              elsif location.y < @d
                Vec2D.new(velocity.x, @maxspeed)
              elsif location.y > height - @d
                Vec2D.new(velocity.x, -@maxspeed)
              end
    return if desired.nil?

    desired.normalize!
    desired *= @maxspeed
    steer = desired - velocity
    steer.set_mag(@maxforce) { steer.mag > @maxforce }
    apply_force(force: steer)
  end

  def display
    theta = velocity.heading + PI / 2
    fill(127)
    stroke(0)
    stroke_weight(1)
    push_matrix
    translate(location.x, location.y)
    rotate(theta)
    begin_shape
    vertex(0, -@r * 2)
    vertex(-@r, @r * 2)
    vertex(@r, @r * 2)
    end_shape(CLOSE)
    pop_matrix
  end
end

attr_reader :seeker

def setup
  sketch_title 'Stay Within Walls'
  @d = 25
  @seeker = Vehicle.new(
    location: Vec2D.new(width / 2, height / 2),
    max_x: width,
    max_y: height,
    safe_distance: @d
  )
end

def draw
  background(255)
  stroke(175)
  no_fill
  rect_mode(CENTER)
  rect(width / 2, height / 2, width - @d * 2, height - @d * 2)
  # Call the appropriate steering behaviors for our agents
  @seeker.boundaries
  @seeker.run
end

def settings
  size(640, 360)
end
