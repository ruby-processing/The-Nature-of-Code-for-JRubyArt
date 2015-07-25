# The Nature of Code
# NOC_6_01_Seek_trail


class Vehicle
  attr_reader :location, :velocity, :acceleration, :world
  def initialize(x, y, world, safe_distance)
    @acceleration = Vec2D.new
    @velocity = Vec2D.new(3, -2)
    @location = Vec2D.new(x, y)
    @r = 6
    @maxspeed = 3
    @maxforce = 0.15
    @world = world
    @d = safe_distance
  end

  def run
    update
    display
  end

  def apply_force(force)
    @acceleration += force
  end

  def update
    @velocity += acceleration
    @velocity.set_mag(@maxspeed) { velocity.mag > @maxspeed }
    @location += velocity
    @acceleration *= 0
  end

  def boundaries
    if location.x < @d
      desired = Vec2D.new(@maxspeed, velocity.y)
    elsif location.x > world.width - @d
      desired = Vec2D.new(-@maxspeed, velocity.y)
    elsif location.y < @d
      desired = Vec2D.new(velocity.x, @maxspeed)
    elsif location.y > world.height - @d
      desired = Vec2D.new(velocity.x, -@maxspeed)
    else
      desired = nil
    end
    return if desired.nil?
    desired.normalize!
    desired *= @maxspeed
    steer = desired - velocity
    steer.set_mag(@maxforce) { steer.mag > @maxforce }
    apply_force(steer)
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
  sketch_title 'Noc 6 03 Stay Within Walls'
  @d = 25
  @seeker = Vehicle.new(width / 2, height / 2, self, @d)
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

