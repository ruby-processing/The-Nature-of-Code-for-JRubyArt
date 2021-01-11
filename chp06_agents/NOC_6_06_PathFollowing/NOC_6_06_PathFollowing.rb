# The Nature of Code
# NOC_6_06_PathFollowing
class Path
  attr_reader :points, :radius

  def initialize
    @radius = 20
    @points = []
  end

  def add_point(x, y)
    points << Vec2D.new(x, y)
  end

  def start
    points[0]
  end

  def finish
    points[-1]
  end

  def display
    draw = proc do |color, weight|
      stroke(color)
      stroke_weight(weight)
      no_fill
      begin_shape
      @points.each { |v| vertex(v.x, v.y) }
      end_shape
    end
    draw.call(175, @radius * 2) # draw thick line with radius
    draw.call(0, 1) # draw thing middle line
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

  def follow(path:)
    # predict location 50 frames ahead
    predict = velocity.copy
    predict.normalize!
    predict *= 50
    predict_loc = location + predict
    worldrecord = 100_000 # far away
    near_target = nil
    normal = nil
    (0...path.points.size - 1).each do |i|
      a = path.points[i]
      b = path.points[i + 1]
      normal_point = get_normal_point(predict_loc, a, b)
      normal_point = b.copy if normal_point.x < a.x || normal_point.x > b.x
      distance = predict_loc.dist(normal_point)
      next unless distance < worldrecord

      worldrecord = distance
      normal = normal_point
      dir = b - a
      dir.normalize!
      dir *= 10
      near_target = normal_point.copy
      near_target += dir
    end
    seek(target: near_target) if worldrecord > path.radius
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
    theta = @velocity.heading + 90.radians
    fill(175)
    stroke(0)
    push_matrix
    translate(@location.x, @location.y)
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
    return if @location.x < path.finish.x + @r

    @location.x = path.start.x - @r
    @location.y = path.start.y + (@location.y - path.finish.y)
  end
end

attr_reader :car1, :car2, :road

def setup
  sketch_title 'Path Following'
  new_path
  @car1 = Vehicle.new(Vec2D.new(0, height / 2), 2, 0.04)
  @car2 = Vehicle.new(Vec2D.new(0, height / 2), 3, 0.1)
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

def new_path
  @road = Path.new
  road.add_point(-20, height / 2)
  road.add_point(rand(0..width / 2), rand(0..height))
  road.add_point(rand(width / 2..width), rand(0..height))
  road.add_point(width + 20, height / 2)
end

def mouse_pressed
  new_path
end

def settings
  size(640, 360)
end
