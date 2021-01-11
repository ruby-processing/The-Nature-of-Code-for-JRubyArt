# The Nature of Code
# NOC_6_09_Flocking
class Boid
  attr_reader :location, :velocity, :acceleration

  def initialize(location:)
    @acceleration = Vec2D.new
    @velocity = Vec2D.new(rand(-1.0..1), rand(-1.0..1))
    @location = location
    @r = 3
    @maxspeed = 3
    @maxforce = 0.05
  end

  def run(boids, width, height)
    flock(boids)
    update
    borders(width, height)
    render
  end

  def apply_force(force:)
    @acceleration += force
  end

  def flock(boids)
    sep = separate(boids)
    ali = align(boids)
    coh = cohesion(boids)
    sep *= 1.5
    apply_force(force: sep)
    apply_force(force: ali)
    apply_force(force: coh)
  end

  def seek(target)
    desired = target - location
    return if desired.mag < EPSILON

    desired.normalize!
    desired *= @maxspeed
    steer = desired - velocity
    steer.set_mag(@maxforce) { steer.mag > @maxforce }
    steer
  end

  def separate(vehicles)
    desired_separation = @r * 2
    sum = Vec2D.new
    count = 0
    vehicles.each do |other|
      next if other.equal? self

      d = location.dist(other.location)
      next unless (EPSILON..desired_separation).cover? d

      diff = (location - other.location).normalize
      diff /= d
      sum += diff
      count += 1
    end
    if count > 0
      sum /= count
      sum.normalize!
      sum *= @maxspeed
      steer = sum + velocity
      steer.set_mag(@maxforce) { steer.mag > @maxforce }
      apply_force(force: steer)
    end
    sum
  end

  def align(boids)
    neighbordist = 50
    sum = Vec2D.new
    count = 0
    boids.each do |other|
      d = location.dist(other.location)
      if (EPSILON..neighbordist).cover? d
        sum += other.velocity
        count += 1
      end
    end
    return Vec2D.new unless count > 0

    sum /= count
    sum.normalize!
    sum *= @maxspeed
    steer = sum - velocity
    steer.set_mag(@maxforce) { steer.mag > @maxforce }
    steer
  end

  def cohesion(boids)
    neighbordist = 50
    sum = Vec2D.new
    count = 0
    boids.each do |other|
      next if other.equal? self

      d = location.dist(other.location)
      if (EPSILON..neighbordist).cover? d
        sum += other.location
        count += 1
      end
    end
    return Vec2D.new unless count > 0

    sum /= count
    seek(sum)
  end

  def update
    @velocity += acceleration
    @velocity.set_mag(@maxspeed) { velocity.mag > @maxspeed }
    @location += velocity
    @acceleration *= 0
  end

  def render
    theta = velocity.heading + 90.radians
    fill(255)
    no_stroke
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

  def borders(width, height)
    @location.x = width + @r if location.x < -@r
    @location.y = height + @r if location.y < -@r
    @location.x = -@r if location.x > width + @r
    @location.y = -@r if location.y < -@r
  end
end

class Flock
  def initialize
    @boids = []
  end

  def run(width, height)
    @boids.each { |b| b.run(@boids, width, height) }
  end

  def add_boid(b)
    @boids << b
  end
end

def setup
  sketch_title 'Flocking'
  @flock = Flock.new
  200.times do
    @flock.add_boid(Boid.new(location: Vec2D.new(width / 2, height / 2)))
  end
end

def draw
  background(20, 20, 235)
  @flock.run(width, height)
end

def mouse_dragged
  @flock.add_boid(Boid.new(location: Vec2D.new(mouse_x, mouse_y)))
end

def settings
  size(640, 360)
  smooth 4
end
