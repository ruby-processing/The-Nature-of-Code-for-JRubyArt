# NOC_02forces_many_attraction_3D
# The Nature of Code
# http://natureofcode.com

class Attractor
  attr_reader :location, :mass

  G = 0.4

  def initialize
    @location = Vec3D.new
    @mass = 20
  end


  def attract(mover)
    force = location - mover.location       # Calculate direction of force
    distance = force.mag                     # Distance between objects
    # Limit "extreme" results for very close or very far objects
    distance = constrain(distance, 5.0, 25.0)
    # Normalize we just want this vector for direction
    force.normalize!
    # Calculate gravitional force magnitude
    strength = (G * mass * mover.mass) / (distance * distance)
    # Get force vector --> magnitude * direction
    force *= strength
    force
  end

  def display
    stroke(255)
    no_fill
    push_matrix
    translate(location.x, location.y, location.z)
    sphere(mass * 2)
    pop_matrix
  end
end

class Mover
  attr_reader :acceleration, :location, :mass, :velocity

  def initialize(m, x, y, z)
    @mass = m
    @location = Vec3D.new(x, y, z)
    @velocity = Vec3D.new(1, 0, 0)
    @acceleration = Vec3D.new
  end

  def apply_force(force)
    @acceleration += force / mass
  end

  def update
    @velocity += acceleration
    @location += velocity
    @acceleration *= 0
  end

  def display
    no_stroke
    fill(255)
    push_matrix
    translate(location.x, location.y, location.z)
    sphere(mass * 8)
    pop_matrix
  end

  def check_edges
    if location.x > width
      location.x = 0;
    elsif location.x < 0
      location.x = width
    end
    if location.y > height
      velocity.y *= -1
      location.y = height
    end
  end
end

# NOC_02forces_many_attraction_3D
def setup
  sketch_title 'Noc 02forces Many Attraction 3 D'
  background(255)
  @movers = Array.new(10) {
                            Mover.new(
                                      rand(0.1 .. 2),
                                      rand(-width/2 .. width/2),
                                      rand(-height/2 .. height/2),
                                      rand(-100 ..100)
                                      )
                           }
  @attractor = Attractor.new
  @angle = 0
end

def draw
  background(0)
  sphere_detail(8)
  lights
  translate(width/2, height/2)
  rotate_y(@angle)
  @attractor.display
  @movers.each do |m|
    force = @attractor.attract(m)
    m.apply_force(force)
    m.update
    m.display
  end
  @angle += 0.003
end

def settings
  size(640, 360, P3D)
end

