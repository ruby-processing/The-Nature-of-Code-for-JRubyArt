# The Nature of Code
# NOC_6_07_Separation

class Vehicle
  attr_reader :acceleration, :location, :velocity

  def initialize(location:)
    @location = location
    @r = 12
    @maxspeed = 3
    @maxforce = 0.2
    @acceleration = Vec2D.new(0, 0)
    @velocity = Vec2D.new(0, 0)
  end

  def apply_force(force:)
    @acceleration += force
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
    return if count == 0

    sum /= count
    sum.normalize!
    sum *= @maxspeed
    steer = sum + velocity
    steer.set_mag(@maxforce) { steer.mag > @maxforce }
    apply_force(force: steer)
  end

  def update
    @velocity += acceleration
    @velocity.set_mag(@maxspeed) { velocity.mag > @maxspeed }
    @location += velocity
    @acceleration *= 0
  end

  def display
    fill(175)
    stroke(0)
    push_matrix
    translate(location.x, location.y)
    ellipse(0, 0, @r, @r)
    pop_matrix
  end

  def borders(width, height)
    location.x = width - @r if location.x < 0
    location.y = height - @r if location.y < 0
    location.x = @r if location.x > width - @r
    location.y = @r if location.y > height - @r
  end
end

def setup
  sketch_title 'Separation'
  @vehicles = Array.new(100) do
    Vehicle.new(location: Vec2D.new(rand(width), rand(height)))
  end
end

def draw
  background(255)
  @vehicles.each do |v|
    v.separate(@vehicles)
    v.update
    v.borders(width, height)
    v.display
  end
end

def mouse_dragged
  @vehicles << Vehicle.new(location: Vec2D.new(mouse_x, mouse_y))
end

def settings
  size(640, 360)
end
