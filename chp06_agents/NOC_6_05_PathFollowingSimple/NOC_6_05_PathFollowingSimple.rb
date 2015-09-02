# The Nature of Code
# NOC_6_05_PathFollowingSimple


class Path
  attr_reader :start, :finish, :radius
  def initialize(start, finish)
    @radius = 20
    @start = start
    @finish = finish
  end

  def display
    stroke_weight(2 * @radius)
    stroke(0, 100)
    line(@start.x, @start.y, @finish.x, @finish.y)
    stroke_weight(1)
    stroke(0)
    line(@start.x, @start.y, @finish.x, @finish.y)
  end
end

class Vehicle
  attr_reader :acceleration, :location, :velocity

  def initialize(location:, maxspeed:, maxforce:)
    @location = location
    @r = 4
    @maxspeed = maxspeed
    @maxforce = maxforce
    @acceleration = Vec2D.new(0, 0)
    @velocity = Vec2D.new(maxspeed, 0)
  end

  def run
    update
    display
  end

  def follow(path:)
    # predict location 50 frames ahead
    predict = velocity.normalize
    predict *= 50
    predict_loc = location + predict
    # look at the line segment
    a = path.start
    b = path.finish
    # get the normal point to that line
    normal_point = get_normal_point(predict_loc, a, b)
    dir = (b - a).normalize
    dir *= 10 # this could be based on velocity instead of arbitrary 10 pixels
    local_target = normal_point + dir
    distance = predict_loc.dist(normal_point)
    seek(target: local_target) if distance > path.radius
  end

  def get_normal_point(p, a, b)
    ap = p - a
    ab = (b - a).normalize
    # project vector "diff" onto line by using the dot product
    ab *= ap.dot(ab)
    a + ab
  end

  def update
    @velocity += acceleration
    @velocity.set_mag(@maxspeed) { velocity.mag > @maxspeed }
    @location += velocity
    @acceleration *= 0
  end

  def apply_force(force:)
    @acceleration += force
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
    # draw a triangle rotated in the direction of the velocity
    theta = velocity.heading + 90.radians
    fill(175)
    stroke(0)
    push_matrix
    translate(location.x, location.y)
    rotate(theta)
    begin_shape(TRIANGLES)
    vertex(0, -@r * 2)
    vertex(-@r, @r * 2)
    vertex(@r, @r * 2)
    end_shape
    pop_matrix
  end

  # wrap around
  def borders(path:)
    if location.x > path.finish.x + @r
      location.x = path.start.x - @r
      location.y = path.start.y + (location.y - path.finish.y)
    end
  end
end

attr_reader :car1, :car2, :road

def setup
  sketch_title 'Path Following Simple'
  start = Vec2D.new(0, height / 3)
  finish = Vec2D.new(width, 2 * height / 3)
  @road = Path.new(start, finish)
  @car1 = Vehicle.new(
    location: Vec2D.new(0, height / 2),
    maxspeed: 2,
    maxforce: 0.02
  )
  @car2 = Vehicle.new(
    location: Vec2D.new(0, height / 2),
    maxspeed: 3,
    maxforce: 0.05
  )
end

def draw
  background(255)
  road.display
  car1.follow(path: road)
  car2.follow(path: road)
  car1.run
  car2.run
  car1.borders(path: road)
  car2.borders(path: road)
end

def settings
  size(640, 360)
end
