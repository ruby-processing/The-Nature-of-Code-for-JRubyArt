# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com

# Pathfinding w/ Genetic Algorithms

# Rocket class -- this is just like our Boid / Particle class
# the only difference is that it has DNA & fitness
class Rocket
  include Processing::Proxy
  # All of our physics stuff
  attr_reader :location, :velocity, :acceleration, :r, :dna, :target
  attr_reader :gene_counter, :hit_target

  # constructor
  def initialize(l, dna, target)
    @location, @dna, @target = l.dup, dna, target
    @acceleration = Vec2D.new
    @velocity = Vec2D.new
    @r = 4
    @gene_counter = 0
    @hit_target = false
  end

  # Fitness function
  # fitness = one divided by distance squared
  def fitness
    d = dist(location.x, location.y, target.x, target.y)
    (1 / d)**2
  end

  # Run in relation to all the obstacles
  # If I'm stuck, don't bother updating or checking for intersection
  def run
    check_target # Check to see if we've reached the target
    unless hit_target
      apply_force(dna.genes[gene_counter])
      @gene_counter = (gene_counter + 1) % dna.genes.length
      update
    end
    display
  end

  # Did I make it to the target?
  def check_target
    @hit_target = dist(location.x, location.y, target.x, target.y) < 12
  end

  def apply_force(f)
    @acceleration += f
  end

  def update
    @velocity += acceleration
    @location += velocity
    @acceleration *= 0
  end

  def display
    theta = velocity.heading + PI / 2
    fill(200, 100)
    stroke(0)
    push_matrix
    translate(location.x, location.y)
    rotate(theta)
    # Thrusters
    rect_mode(CENTER)
    fill(0)
    rect(-r / 2.0, r * 2, r / 2.0, r)
    rect(r / 2.0, r * 2, r / 2.0, r)
    # Rocket body
    fill(175)
    begin_shape(TRIANGLES)
    vertex(0, -r * 2)
    vertex(-r, r * 2)
    vertex(r, r * 2)
    end_shape
    pop_matrix
  end
end
