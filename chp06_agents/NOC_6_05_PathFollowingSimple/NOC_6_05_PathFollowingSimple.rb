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

  def initialize(loc, ms, mf)
    @location = loc.copy
    @r = 4
    @maxspeed = ms
    @maxforce = mf
    @acceleration = Vec2D.new(0, 0)
    @velocity = Vec2D.new(@maxspeed, 0)
  end

  def run
    update
    display
  end

  def follow(path)
    # predict location 50 frames ahead
    predict = velocity.copy
    predict.normalize!
    predict *= 50
    predict_loc = location + predict
    # look at the line segment
    a = path.start
    b = path.finish
    # get the normal point to that line
    normal_point = get_normal_point(predict_loc, a, b)
    dir = b - a
    dir.normalize!
    dir *= 10 # this could be based on velocity instead of arbitrary 10 pixels
    target = normal_point + dir
    distance = predict_loc.dist(normal_point)
    seek(target) if distance > path.radius
  end

  def get_normal_point(p, a, b)
    ap = p - a
    ab = b - a
    ab.normalize!
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

  def apply_force(force)
    @acceleration += force
  end

  def seek(target)
    desired = target - location
    return if desired.mag < PConstants.EPSILON
    desired.normalize!
    desired *= @maxspeed
    steer = desired - velocity
    steer.set_mag(@maxforce) { steer.mag > @maxforce }
    apply_force(steer)
  end

  def display
    # draw a triangle rotated in the direction of the velocity
    theta = velocity.heading + 90.radians
    fill(175)
    stroke(0)
    push_matrix
    translate(location.x, location.y)
    rotate(theta)
    begin_shape(PConstants.TRIANGLES)
    vertex(0, -@r * 2)
    vertex(-@r, @r * 2)
    vertex(@r, @r * 2)
    end_shape
    pop_matrix
  end

  # wrap around
  def borders(path)
    if location.x > path.finish.x + @r
      @location.x = path.start.x - @r
      @location.y = path.start.y + (location.y - path.finish.y)
    end
  end
end

def setup
  sketch_title 'Noc 6 05 Path Following Simple'
  start = Vec2D.new(0, height / 3)
  finish = Vec2D.new(width, 2 * height / 3)
  @path = Path.new(start, finish)
  @car1 = Vehicle.new(Vec2D.new(0, height / 2), 2, 0.02)
  @car2 = Vehicle.new(Vec2D.new(0, height / 2), 3, 0.05)
end

def draw
  background(255)
  @path.display
  @car1.follow(@path)
  @car2.follow(@path)
  @car1.run
  @car2.run
  @car1.borders(@path)
  @car2.borders(@path)
end

def settings
  size(640, 360)
end

