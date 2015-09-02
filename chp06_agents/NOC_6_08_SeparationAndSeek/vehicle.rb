class Vehicle
  include Processing::Proxy
  attr_reader :location, :velocity, :acceleration
  def initialize(location:)
    @location = location
    @r = 12
    @maxspeed = 3
    @maxforce = 0.2
    @acceleration = Vec2D.new
    @velocity = Vec2D.new
  end

  def apply_force(force:)
    @acceleration += force
  end

  def apply_behaviors(vehicles)
    separate_force = separate(vehicles)
    seek_force = seek(Vec2D.new(mouse_x, mouse_y))
    separate_force *= 2
    apply_force(force: separate_force)
    apply_force(force: seek_force)
  end

  def seek(target)
    desired = target - location
    return desired if desired.mag < EPSILON
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
      next unless (EPSILON..desired_separation).include? d
      diff = (location - other.location).normalize
      diff /= d
      sum += diff
      count += 1
    end
    return sum if count == 0
    sum /= count
    sum.normalize!
    sum *= @maxspeed
    steer = sum + velocity
    steer.set_mag(@maxforce) { steer.mag > @maxforce }
    sum
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
