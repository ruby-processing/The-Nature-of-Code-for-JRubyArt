# The Nature of Code
# NOC_6_01_Seek_trail


class Vehicle
  attr_reader :location, :velocity, :acceleration, :history
  def initialize(location:)
    @acceleration = Vec2D.new
    @velocity = Vec2D.new(0, -2)
    @location = location
    @r = 6
    @maxspeed = 4
    @maxforce = 0.1
    @history = []
  end

  def apply_force(force:)
    @acceleration += force
  end

  def update
    @velocity += acceleration
    @velocity.set_mag(@maxspeed) { velocity.mag > @maxspeed }
    @location += velocity
    @acceleration *= 0
    history << location.copy
    history.shift if history.size > 100
  end

  def seek(target:)
    desired = target - location
    return if desired.mag < EPSILON
    desired.normalize!
    desired *= @maxspeed
    steer = desired - velocity
    steer.set_mag(@maxforce) { steer.mag > @maxforce }
    apply_force(force: steer)
  end

  def display
    begin_shape
    stroke(0)
    stroke_weight(1)
    no_fill
    @history.each { |v| vertex(v.x, v.y) }
    end_shape
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
  sketch_title 'Seek Trail'
  @seeker = Vehicle.new(location: Vec2D.new(width / 2, height / 2))
end

def draw
  background(255)
  mouse = Vec2D.new(mouse_x, mouse_y)
  fill(200)
  stroke(0)
  stroke_weight(2)
  ellipse(mouse.x, mouse.y, 48, 48)
  # Call the appropriate steering behaviors for our agents
  seeker.seek(target: mouse)
  seeker.update
  seeker.display
end

def settings
  size(640, 360)
end

